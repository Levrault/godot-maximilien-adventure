extends Node

var path := ''
var save_data := {}
const CHAPTER_NUMBER := 2


""" 
Create a new profile
@param {String} profile_name
"""
func create_profile(profile_name: String) -> void:
	save_game(path, profile_name, 1)


""" 
Save player's profile data and settings
@param {String} path (profile0, profile1, profile2)
@param {String} name
@param {int} level
"""
func save_game(path: String, name: String, level: int) -> void:
	var save_game = File.new()
	save_game.open("user://%s.save" % [path], File.WRITE)
	var data := {
		"name": name,
		"current_level": level,
		"levels": _generate_level_data()
	}
	save_game.store_line(to_json(data))
	save_game.close()


"""
Load game progression
@param {String} path
"""
func load_game(path: String) -> void:
	var save_game = File.new()
	if not save_game.file_exists("user://%s.save" % [path]):
		save_data = {}
		return 
	save_game.open("user://%s.save" % [path], File.READ)
	save_data = parse_json(save_game.get_line())
	save_game.close()


"""
Generate all futur level data
@return {Dictionary}
"""
func _generate_level_data() -> Dictionary:
	var chapter := {}
	var i := 1
	while i < CHAPTER_NUMBER:
		chapter["chapter_%s" % [i]] = {
			"title": "CHAPTER_%s" % [i],
			"gems_collected": 0,
			"m_letter_found": false,
			"a_letter_found": false,
			"x_letter_found": false,
			"completed": false
		}
		i += 1
	return chapter
