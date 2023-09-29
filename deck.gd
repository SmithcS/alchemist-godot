class_name Deck

var cards: Array[Card]
	
func _init(card_ids: Array[int]):
	for id in card_ids:
		var card = Card.by_id(id)
		cards.append(card)
