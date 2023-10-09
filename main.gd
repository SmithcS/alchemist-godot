extends Node

@export var player_node_path: NodePath
@export var golem_node_path: NodePath
@export var enemy_scene: PackedScene

@onready var world := $World
@onready var player: Player = get_node(player_node_path)
@onready var golem: Golem = get_node(golem_node_path)
@onready var ui := $UI

var deck_manager = DeckManager.new(2)

func _ready():
	print("player deck: " + deck_manager.deck.to_string())
	golem.set_home(player)
	_create_chest()
	_create_enemy()
	deck_manager.draw_hand()

func _process(delta):
	if Input.is_action_pressed("cardSlot1"):
		var cast_occured = player.cast_manager.cast()
		
		if cast_occured:
			deck_manager.discard_hand()
			deck_manager.draw_hand()
			
			print("player deck: ", deck_manager.deck.to_string())
			print("player discards: ", deck_manager.discards.to_string())
			print("player hand: ", deck_manager.hand)

func _create_chest():
	var chest = preload("res://chest.tscn").instantiate()
	chest.position.x = 300
	chest.position.y = 100
	world.add_child(chest)
	
func _create_enemy():
	var enemy = enemy_scene.instantiate()
	enemy.position.x = 500
	enemy.position.y = 300
	world.add_child(enemy)
