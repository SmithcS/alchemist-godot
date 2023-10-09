class_name Golem

extends CharacterBody2D

@export var speed: int = 300
@export var sight_distance: int = 400
@export var fov: int = 120

var _is_home: bool = true
var _home: Area2D 
var _node_vision_manager: NodeVisionManager

func _ready():
	_node_vision_manager = NodeVisionManager.new(self, sight_distance, fov)

func _physics_process(delta):
	if not _is_home:
		_go_home()

func _go_home():
	var direction = position.direction_to(_home.global_position)
	velocity = direction * speed
	move_and_slide()

func set_home(p_home: Node):
	var shape :=  CircleShape2D.new()
	shape.radius = 20

	var collision_shape := CollisionShape2D.new()
	collision_shape.shape = shape

	var home := Area2D.new()
	home.add_child(collision_shape)
	home.name = "GolemHome"
	home.body_entered.connect(_on_home_area_body_entered)
	home.body_exited.connect(_on_home_area_body_exited)

	p_home.add_child(home)
	_home = home

func _on_home_area_body_exited(body: Node2D):
	_is_home = false
	print("golem exited home")

func _on_home_area_body_entered(body: Node2D):
	_is_home = true
	print("golem entered home")
