class_name Enemy

extends CharacterBody2D

@export var speed: int = 200
@export var sight_distance: int = 300
@export var ray_cast_path: NodePath

@onready var ray_cast_node: RayCast2D = get_node(ray_cast_path)

var node_vision_manager: NodeVisionManager

func _ready():
	node_vision_manager = NodeVisionManager.new(self, sight_distance, 60)
	
func _physics_process(delta):
	if _can_see_player():
		var target := _get_seen_player()
		print(target)
		node_vision_manager.align_with_target(target)
		_follow_target(target)
			
func _follow_target(target: Node):
	var direction: Vector2 = (target.position - position).normalized()
	velocity = direction * speed
	move_and_slide()

func _can_see_player() -> bool:
	if node_vision_manager.is_colliding():
		return (
			node_vision_manager
				.get_collider()
				.any(func(obj): return obj is Player)
		)
	return false

func _get_seen_player() -> Player:
	var colliders := node_vision_manager.get_collider()
	for collider in colliders:
		if collider is Player:
			return collider
	return null
