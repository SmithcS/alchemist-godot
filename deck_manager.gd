extends Node

class_name DeckManager

var deck: Deck
var discards: Deck
var hand: Array[Card]
var hand_size: int

var _default_card_ids: Array[int] = [1, 2]

signal hand_drawn(cards: Array[Card])

func _init(p_hand_size: int):
	deck = _default_deck()
	discards = Deck.new()
	hand = []
	hand_size = p_hand_size

func _default_deck() -> Deck:
	return Deck.new(_default_card_ids)

# Make a cast mangager
# Orchestrates the decks manager and the UI
# Sends signals as needed to make the player cast and UI update
func draw_hand():
	discard_hand()
	var drawn_cards := []
	
	while (hand.size() < hand_size):
		if deck.is_empty():
			shuffle()
		
		# store drawn card for emitting
		var drawn_card := deck.draw()
		hand.append(drawn_card)
		drawn_cards.append(drawn_card)
	
	hand_drawn.emit(drawn_cards)

func discard_hand():
	discards.add_all(hand)

func shuffle():
	deck = deck.combine(discards)
	discards.clear()
	deck.shuffle()

