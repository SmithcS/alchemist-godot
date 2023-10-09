extends CharacterBody2D

class_name Enemy

@export var speed: int = 200
@export var sight_distance: int = 300
@export var ray_cast_path: NodePath

@onready var ray_cast_node: RayCast2D = get_node(ray_cast_path)

var node_vision_manager: NodeVisionManager
signal player_sighted

func _ready():
	node_vision_manager = NodeVisionManager.new(self, sight_distance, 60)
	
func _physics_process(delta):
	if node_vision_manager.is_colliding():
		print("is colliding")
		if node_vision_manager.get_collider() is Player:
			var target: Player = node_vision_manager.get_collider() 
			
			node_vision_manager.align_with_target(target)
			_move_follow_target(target)
			
func _move_follow_target(target: Node):
	var direction: Vector2 = (target.position - position).normalized()
	velocity = direction * speed
	move_and_slide()
	
func _sight_follow_target(target: Node):
	var direction: Vector2 = (target.position - position).normalized()
	ray_cast_node.target_position = sight_distance * direction

