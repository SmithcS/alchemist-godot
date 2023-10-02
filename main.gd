extends Node

var deck_manager = DeckManager.new(2)
@onready var player := $Player
@onready var ui := $UI

func _ready():
	print("mydeck: " + deck_manager.deck.to_string())
	deck_manager.hand_drawn.connect(ui._on_deck_manager_hand_drawn)
	deck_manager.draw_hand()
	# Make this a signal whenever a draw_hand happens
	ui.update_for_cards(deck_manager.hand)

func _process(delta):
	if Input.is_action_pressed("cardSlot1"):
		player.cast()
		deck_manager.discard_hand()
		deck_manager.draw_hand()

