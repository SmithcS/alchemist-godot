class_name CardManager

var deck: Deck
var _default_card_guids: Array[int] = [1, 2]

# TODO consider making this global, maybe
# Format <K, V>:
# K - Global unique ID for card
# V - Card data
enum CardType { ATTACK, DEFENSE, UTILITY }
static var master_card_list = {
	0: {
		"cost": 0,
		"name": "Invalid Card"
	},
	1: {
		"type": CardType.ATTACK,
		"cost": 1,
		"name": "Rock",
		"damage": 10
	},
	2: {
		"type": CardType.ATTACK,
		"cost": 2,
		"name": "Big Rock",
		"damage": 20
	}
}

static var _INVALID_CARD: Card = Card.new(
	0,
	master_card_list[0]["cost"],
	master_card_list[0]["name"]
)

func _init():
	deck = default_deck()

func default_deck() -> Deck:
	return Deck.new(_default_card_guids)

class Deck:
	var cards: Array[Card]
	
	func _init(card_guids: Array[int]):
		for guid in card_guids:
			var card_config = CardManager.master_card_list[guid]
			var card = CardManager.card_from_config(guid, card_config)
			cards.append(card)
	
class Card:
	var guid: int
	var cost: int
	var name: String
	
	func _init(p_guid: int, p_cost: int, p_name: String):
		guid = p_guid
		cost = p_cost
		name = p_name
		
	func _to_string() -> String:
		return "guid: %s, cost: %s, name: %s" % [guid, cost, name]
	
class AttackCard extends Card:
	var damage: int
	
	func _init(p_guid: int, p_cost: int, p_name: String, p_damage: int):
		super(p_guid, p_cost, p_name)
		damage = p_damage
		
	func _to_string() -> String:
		return super._to_string() + (", damage: %s" % damage)
	
class DefenseCard extends Card:
	var block: int
	
	func _init(p_guid: int, p_cost: int, p_name: String, p_block: int):
		super(p_guid, p_cost, p_name)
		block = p_block
	
class UtilityCard extends Card:
	# No clue what this will do yet 
	var data: String
	
# TODO: Create real type to represetn card config
# Validate card config
static func card_from_config(guid: int, card_config: Dictionary) -> Card:
	match card_config["type"]:
		CardType.ATTACK:
			return AttackCard.new(
				guid,
				card_config["cost"],
				card_config["name"],
				card_config["damage"]
			)
		CardType.DEFENSE:
			return DefenseCard.new(
				guid,
				card_config["cost"],
				card_config["name"],
				card_config["block"]
			)
		_:
			assert(false)
			# TODO: you can't throw in godot... 
			return _INVALID_CARD
