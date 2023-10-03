extends Node

class_name CastManager

var projectile_scene = load("res://projectile.tscn")

var can_cast: bool = true

var player: CharacterBody2D
var projectile_spawn: Marker2D

var rock_texture = preload("res://16_rock.svg")
var icicle_texture = preload("res://16_icicle.svg")
var ice_rock_texture = preload("res://16_ice_rock.svg")

#func _init(p_player, p_projectile_spawn):
#	player = p_player
#	projectile_spawn = p_projectile_spawn
	
func cast():
	if not can_cast:
		return
		
	var projectile = projectile_scene.instantiate()
	var projectile_sprite = projectile.get_node("Sprite2D")
	
	projectile_sprite.set_texture(rock_texture)
	
	player.add_child(projectile)
	
	projectile.transform = projectile_spawn.transform
	
	can_cast = false
	$CastCooldown.start()

func _on_cast_cooldown_timeout():
	can_cast = true
