extends CharacterBody2D

class_name Enemy

@export var sight_distance: int = 170
@export var ray_cast_path: NodePath

@onready var ray_cast_node: RayCast2D = get_node(ray_cast_path)

signal player_sighted

func _ready():
	ray_cast_node.target_position.x = sight_distance
	
func _physics_process(delta):
	if ray_cast_node.is_colliding():
		if ray_cast_node.get_collider() is Player:
			var target: Object = ray_cast_node.get_collider()
			
	

