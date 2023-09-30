class_name Deck

var cards: Array[Card]
	
func _init(card_ids: Array[int]):
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
	
func draw() -> Card:
	var card = cards.back()
	
	if card == null:
		assert(false)
		
	return card
	
