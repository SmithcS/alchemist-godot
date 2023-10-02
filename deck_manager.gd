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
	hand_size = p_hand_size

func _default_deck() -> Deck:
	return Deck.new(_default_card_ids)

# Make a cast mangager
# Orchestrates the decks manager and the UI
# Sends signals as needed to make the player cast and UI update
func draw_hand():
	discard_hand()
	
	while (hand.size() < hand_size):
		hand.append(deck.draw())

func discard_hand():
	discards.append_array(hand)

func shuffle():
	deck = deck.combine(discards)
	discards.clear()
	deck.shuffle()

