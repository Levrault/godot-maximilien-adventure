extends Node

const DEFAULT_LEVEL_DATA := {
	"gems_collected": 0,
	"m_letter_found": false,
	"a_letter_found": false,
	"x_letter_found": false,
	"completed": false
}
const JSON_READER: Script = preload("res://text/JSONReader.gd")
const JSON_PATH := "res://config.json"

var path := "" setget _set_path
var save_data := {}
var config_data := JSON_READER.get_json(JSON_PATH, "overworld")


# Generate all futur level data
# @return {Dictionary}
func _generate_level_data() -> Dictionary:
	var chapter := {}
	var i := 1
	while i <= config_data.size():
		chapter["chapter_%s" % [i]] = DEFAULT_LEVEL_DATA.duplicate()
		i += 1
	return chapter


# Set save path
func _set_path(profile: String) -> void:
	path = "user://%s.save" % [profile]


# sync save file with new added level in config.json 
func _sync_with_json_file() -> void:
	for json in config_data:
		if not save_data.levels.has(json.key):
			save_data.levels[json.key] = DEFAULT_LEVEL_DATA.duplicate()


# Save player's profile data and settings
# @param {String} path (profile0, profile1, profile2)
# @param {String} name
# @param {int} level
func create_save_file(name: String, level: int) -> void:
	assert(path != "")

	var file = File.new()
	file.open(path, File.WRITE)
	var data := {"name": name, "current_level": level, "levels": _generate_level_data()}
	file.store_line(to_json(data))
	file.close()


# Save a game
# @param {String} path
func save_game() -> void:
	var save_game = File.new()
	if not save_game.file_exists(path):
		print("Cannot load %s, it was not found" % [path])
		save_data = {}
		return
	save_game.open(path, File.WRITE_READ)
	_sync_with_json_file()
	save_game.store_line(to_json(save_data))
	save_game.close()
	print("update save game for %s" % [path])


# Load game progression
# @param {String} path
func load_game() -> void:
	var save_game = File.new()
	if not save_game.file_exists(path):
		print("Cannot load %s, it was not found" % [path])
		save_data = {}
		return
	save_game.open("%s" % [path], File.READ)
	save_data = parse_json(save_game.get_line())
	_sync_with_json_file()
	save_game.close()
	print("%s has been loaded" % [path])


# Delete save data
func delete_save_game(file_path: String) -> void:
	var save_game = File.new()
	if not save_game.file_exists("user://%s.save" % [file_path]):
		print("Cannot delete user://%s.save, it was not found" % [file_path])
		save_data = {}
		return
	else:
		var dir = Directory.new()
		dir.remove("user://%s.save" % [file_path])
		print("user://%s.save was deleted" % [file_path])


# Completed level date
# @param {String} level
# @param {int} gems
# @param {Dictionary} letters
func level_completed(level: String, gems: int, letters: Dictionary) -> void:
	assert(level != "")
	assert(path != "")

	# if a new level is added to json config
	var previous_data = save_data.levels[level]
	save_data.levels[level].gems_collected = (
		gems
		if previous_data.gems_collected < gems
		else previous_data.gems_collected
	)
	save_data.levels[level].m_letter_found = (
		letters.M
		if not previous_data.m_letter_found
		else previous_data.m_letter_found
	)
	save_data.levels[level].a_letter_found = (
		letters.A
		if not previous_data.a_letter_found
		else previous_data.a_letter_found
	)
	save_data.levels[level].x_letter_found = (
		letters.X
		if not previous_data.x_letter_found
		else previous_data.x_letter_found
	)
	save_data.levels[level].completed = true
	# remove chapter_ to get the number
	var level_index := level.substr(8, level.length()).to_int() + 1
	if level_index > save_data.current_level and level_index <= config_data.size():
		save_data.current_level = level_index
