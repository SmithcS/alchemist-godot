class_name Card

var id: int
var cost: int
var name: String

func _init(p_id: int, p_cost: int, p_name: String):
	id = p_id
	cost = p_cost
	name = p_name
	
func _to_string() -> String:
	return "id: %s, cost: %s, name: %s" % [id, cost, name]
	
# TODO: Create real type to represetn card config
# Validate card config
static func by_id(id: int) -> Card:
	var card_config = Card.master_card_list[id]
	
	match card_config["type"]:
		CardType.ATTACK:
			return AttackCard.new(
				id,
				card_config["cost"],
				card_config["name"],
				card_config["damage"]
			)
		CardType.DEFENSE:
			return DefenseCard.new(
				id,
				card_config["cost"],
				card_config["name"],
				card_config["block"]
			)
		_:
			assert(false)
			# TODO: you can't throw in godot... 
			return _INVALID_CARD
	
class AttackCard extends Card:
	var damage: int
	
	func _init(p_id: int, p_cost: int, p_name: String, p_damage: int):
		super(p_id, p_cost, p_name)
		damage = p_damage
		
	func _to_string() -> String:
		return super._to_string() + (", damage: %s" % damage)
		
	
class DefenseCard extends Card:
	var block: int
	
	func _init(p_id: int, p_cost: int, p_name: String, p_block: int):
		super(p_id, p_cost, p_name)
		block = p_block
	
class UtilityCard extends Card:
	# No clue what this will do yet 
	var data: String
	
static var _INVALID_CARD: Card = Card.new(
	0,
	master_card_list[0]["cost"],
	master_card_list[0]["name"]
)

# TODO consider making this global, maybe
# Format <K, V>:
# K - Unique ID for card
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

