extends CharacterBody2D

class_name Enemy

@export var speed: int = 200
@export var sight_distance: int = 300
@export var ray_cast_path: NodePath

@onready var ray_cast_node: RayCast2D = get_node(ray_cast_path)

signal player_sighted

func _ready():
	ray_cast_node.target_position.x = sight_distance
	
func _physics_process(delta):
	if ray_cast_node.is_colliding():
		if ray_cast_node.get_collider() is Player:
			var target: Player = ray_cast_node.get_collider()
			_sight_follow_target(target)
			_move_follow_target(target)
			
func _move_follow_target(target: Node):
	var direction: Vector2 = (target.position - position).normalized()
	velocity = direction * speed
	move_and_slide()
	
func _sight_follow_target(target: Node):
	var direction: Vector2 = (target.position - position).normalized()
	ray_cast_node.target_position = sight_distance * direction

