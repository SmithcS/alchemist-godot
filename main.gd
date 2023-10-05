extends Node

var deck_manager = DeckManager.new(2)

@onready var player: Player = $Player
@onready var ui := $UI

func _ready():
	print("player deck: " + deck_manager.deck.to_string())
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
			


		
