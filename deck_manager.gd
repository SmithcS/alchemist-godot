extends Node

class_name DeckManager

var deck: Deck
var discards: Deck
var hand: Array[Card]
var hand_size: int

var _default_card_ids: Array[int] = [1, 2]

func _init(p_hand_size: int):
	deck = _default_deck()
	discards = Deck.new()
	hand = []
	hand_size = p_hand_size

func _default_deck() -> Deck:
	return Deck.new(_default_card_ids)

func draw_hand():
	discard_hand()
	var drawn_cards: Array[Card] = []
	
	while (hand.size() < hand_size):
		if deck.is_empty():
			shuffle()
		
		var drawn_card := deck.draw()
		hand.append(drawn_card)
		drawn_cards.append(drawn_card)
	
	EventBus.hand_drawn.emit(drawn_cards)

func discard_hand():
	discards.add_all(hand)
	hand = []

func shuffle():
	deck.combine(discards)
	discards.clear()
	deck.shuffle()

