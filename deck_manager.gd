class_name DeckManager

var deck: Deck
var _default_card_ids: Array[int] = [1, 2]

func _init():
	deck = _default_deck()

func _default_deck() -> Deck:
	return Deck.new(_default_card_ids)

