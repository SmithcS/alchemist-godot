extends CenterContainer

signal update_health(amount: float)

@export var texture_progress_bar_path: NodePath
@export var min_bar_x_size: int = 600

@onready var texture_progress_bar: TextureProgressBar = get_node(texture_progress_bar_path)

func _ready():
	texture_progress_bar.custom_minimum_size.x = min_bar_x_size

func _on_update_health(amount: float):
	texture_progress_bar.value = amount

	var tween = create_tween()
	tween.tween_property(texture_progress_bar, "value", texture_progress_bar.value, 0.50).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
