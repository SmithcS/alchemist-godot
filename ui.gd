extends MarginContainer

var idx_to_slot_map := {
	0: $Cards.get_node("CardSlot1"),
	1: $Cards.get_node("CardSlot2"),
	2: $Cards.get_node("CardSlot3"),
}

func _ready():
	EventBus.hand_drawn.connect(_on_hand_drawn)

func update_for_cards(cards: Array[Card]):
	for idx in range(0, cards.size()):
		var card_slot = idx_to_slot_map.get(idx)
		
		card_slot.get_node("CardName").text = cards[idx].name
		
func _on_hand_drawn(drawn_cards: Array[Card]):
	update_for_cards(drawn_cards)

