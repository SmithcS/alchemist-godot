extends CharacterBody2D

# How fast the player will move (pixels/sec)
@export var speed = 400
@export var projectile_scene : PackedScene

var deck_manager = DeckManager.new(2)

var rock_texture = preload("res://16_rock.svg")
var icicle_texture = preload("res://16_icicle.svg")
var ice_rock_texture = preload("res://16_ice_rock.svg")

signal card_cast

func _ready():
	print(deck_manager.deck.to_string())
	
	
func cast():
	var projectile = projectile_scene.instantiate()
	var projectile_sprite = projectile.get_node("Sprite2D")
	
	projectile_sprite.set_texture(rock_texture)
		
	add_child(projectile)
	
	projectile.transform = $ProjectileSpawn.transform
	#projectile.rotation = $ProjectileSpawn.rotation
		
func _process(delta):
	pass
	
func _physics_process(delta):
	# Reset the player's velocity
	velocity = Vector2(0, 0)
	var mouse_position = get_global_mouse_position()

	# This input will need to be created in the input map
	if Input.is_action_pressed("move"):
		var raw_direction = mouse_position - position
		if raw_direction.length() > 10:
			velocity = (raw_direction.normalized() * speed)

	if velocity.x != 0:
		$Sprite2D.flip_h = velocity.x < 0

	move_and_slide()
	projectile_spawn_face_mouse(mouse_position)
	
# Find where on a circle around the player the projectile spawn should face
func projectile_spawn_face_mouse(global_mouse_position: Vector2):
	var direction: Vector2 = (global_mouse_position - $Sprite2D.global_position).normalized()
	$ProjectileSpawn.position = direction * 15
	$ProjectileSpawn.rotation = direction.angle()
