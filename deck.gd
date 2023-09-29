class_name Deck

var cards: Array[Card]
	
func _init(card_guids: Array[int]):
	for guid in card_guids:
		var card = Card.by_guid(guid)
		cards.append(card)
