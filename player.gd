extends CharacterBody2D

# How fast the player will move (pixels/sec)
@export var speed = 400
@export var projectile_scene : PackedScene

var card_manager = CardManager.new()

var rock_texture = preload("res://16_rock.svg")
var icicle_texture = preload("res://16_icicle.svg")
var ice_rock_texture = preload("res://16_ice_rock.svg")

var elementSet = {}

func _ready():
	print(card_manager.deck.cards)
	
func cast():
	var projectile = projectile_scene.instantiate()
	var projectile_sprite = projectile.get_node("Sprite2D")
	
	if elementSet.has("ice") and elementSet.has("rock"):
		projectile_sprite.set_texture(ice_rock_texture)
	elif elementSet.has("ice"):
		projectile_sprite.set_texture(icicle_texture)
	elif elementSet.has("rock"):
		projectile_sprite.set_texture(rock_texture)
		
	add_child(projectile)
	
	projectile.transform = $ProjectileSpawn.transform
	#projectile.rotation = $ProjectileSpawn.rotation
	elementSet.clear()
		
func _process(delta):
	if Input.is_action_just_pressed("element1"):
		elementSet["ice"] = true
	if Input.is_action_just_pressed("element2"):
		elementSet["rock"] = true
	if Input.is_action_just_pressed("cast"):
		cast()
	
func _physics_process(delta):
	# Reset the player's velocity
	velocity = Vector2(0, 0)
	var mouse_position = get_global_mouse_position()

	# This input will need to be created in the input map
	if Input.is_action_pressed("move"):
		var direction = (mouse_position - position).normalized()
		velocity = (direction * speed)

	if velocity.x != 0:
		$Sprite2D.flip_h = velocity.x < 0

	move_and_slide()
	projectile_spawn_face_mouse(mouse_position)
	
# Find where on a circle around the player the projectile spawn should face
func projectile_spawn_face_mouse(global_mouse_position: Vector2):
	var direction: Vector2 = (global_mouse_position - $Sprite2D.global_position).normalized()
	$ProjectileSpawn.position = direction * 15
	$ProjectileSpawn.rotation = direction.angle()
