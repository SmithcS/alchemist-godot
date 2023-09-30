extends Node

var _master_card_list_config_path: String = "res://master_card_list.json"
var _master_card_list: Dictionary = {}

enum CardType { ATTACK, DEFENSE, UTILITY }

func master_card_list() -> Dictionary:
	if _master_card_list.size() == 0:
		_load_card_config()
	return _master_card_list

func _load_card_config():
	var file = FileAccess.open(_master_card_list_config_path, FileAccess.READ)
	var data: Dictionary = JSON.parse_string(file.get_as_text())
	
	_master_card_list = _format_card_config_json(data)

func _validate_card_config_file():
	if not FileAccess.file_exists(_master_card_list_config_path):
		print("master card list config missing at path %s", _master_card_list_config_path)
		assert(false)
	
func _format_card_config_json(config_json: Dictionary) -> Dictionary:
	var formatted_config = {}

	for id in config_json.keys():
		formatted_config[int(id)] = config_json[id]
		if formatted_config[int(id)].has("type"):
			formatted_config[int(id)]["type"] = CardType.get(formatted_config[int(id)]["type"])
	
	return formatted_config
		
