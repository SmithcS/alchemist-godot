class_name Deck

var cards: Array[Card]
	
func _init(card_ids: Array[int] = []):
	for id in card_ids:
		var card = Card.by_id(id)
		cards.append(card)

func _to_string() -> String:
	var str: String = ""
	for card in cards:
		str += "[%s]" % card.to_string()
	return str

func add(card: Card):
	cards.append(card)
	
func add_all(p_cards: Array[Card]):
	cards.append_array(p_cards)
	
func combine(p_deck: Deck):
	cards.append_array(p_deck.cards)
	
func draw() -> Card:
	var card = cards.back()
	
	# This means the deck is empty, and we should reshuffle. Currently asserts
	# false because we shouldn't be drawing from empty decks
	if card == null:
		assert(false)
		
	cards.erase(card)

	return card
	
func shuffle():
	randomize()
	print(cards)
	cards.shuffle()
	
func clear():
	cards = []
	
func is_empty() -> bool:
	return cards.is_empty()
