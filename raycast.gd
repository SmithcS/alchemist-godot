extends RayCast2D

@export var line_2d_path: NodePath

@onready var visual_line: Line2D = get_node(line_2d_path)

func _ready():
	visual_line.add_point(target_position)

func _process(delta):
	# Update visual line to follow the actual raycast
	visual_line.set_point_position(1, target_position)
