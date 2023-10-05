extends Node

class_name CastManager

# What Node should own the created projectiles
var parent: Node
# What Marker2D the projectiles should spawn from
var projectile_spawn: Marker2D

var _projectile_scene = load("res://projectile.tscn")
var _can_cast: bool = true

var rock_texture = preload("res://16_rock.svg")
var icicle_texture = preload("res://16_icicle.svg")
var ice_rock_texture = preload("res://16_ice_rock.svg")

func configure(p_parent: Node, p_projectile_spawn: Marker2D):
	parent = p_parent
	projectile_spawn = p_projectile_spawn
	
func cast() -> bool:
	if not _can_cast:
		return false
		
	var projectile = _projectile_scene.instantiate()
	var projectile_sprite = projectile.get_node("Sprite2D")
	
	projectile_sprite.set_texture(rock_texture)
	projectile.transform = projectile_spawn.transform

	parent.add_child(projectile)
	
	_can_cast = false
	$CastCooldown.start()
	return true

func _on_cast_cooldown_timeout():
	_can_cast = true
