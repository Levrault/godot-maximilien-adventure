extends Node

var path := '' setget _set_path
var save_data := {}
const CHAPTER_NUMBER := 2

"""
Generate all futur level data
@return {Dictionary}
"""
func _generate_level_data() -> Dictionary:
	var chapter := {}
	var i := 1
	while i <= CHAPTER_NUMBER:
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


"""
Set save path
"""
func _set_path(profile: String) -> void:
	path = "user://%s.save" % [profile]


""" 
Save player's profile data and settings
@param {String} path (profile0, profile1, profile2)
@param {String} name
@param {int} level
"""
func create_save_file(name: String, level: int) -> void:
	assert (path != "")
	
	var file = File.new()
	file.open(path, File.WRITE)
	var data := {
		"name": name,
		"current_level": level,
		"levels": _generate_level_data()
	}
	file.store_line(to_json(data))
	file.close()



"""
Save a game
@param {String} path
"""
func save_game() -> void:
	var save_game = File.new() 
	save_game.open(path, File.WRITE_READ)
	save_game.store_line(to_json(save_data))
	save_game.close()
	print("update save game for %s" % [path])
	print(save_data)


"""
Load game progression
@param {String} path
"""
func load_game() -> void:
	var save_game = File.new()
	if not save_game.file_exists(path):
		print("Cannot load %s, it was not found" % [path])
		save_data = {}
		return 
	save_game.open("%s" % [path], File.READ)
	save_data = parse_json(save_game.get_line())
	save_game.close()
	print("%s has been loaded" % [path])


"""
Delete save data
"""
func delete_save_game(path: String) -> void:
	var save_game = File.new()
	if not save_game.file_exists("user://%s.save" % [path]):
		print("Cannot delete user://%s.save, it was not found" % [path])
		save_data = {}
		return
	else:
		var dir = Directory.new()
		dir.remove("user://%s.save" % [path])
		print("user://%s.save was deleted" % [path])


"""
Completed level date
@param {String} level
@param {int} gems
@param {Dictionary} letters
"""
func level_completed(level:String, gems: int, letters: Dictionary) -> void:
	assert (level != "")
	assert (path != "")
	save_data.levels[level].gems_collected = gems
	save_data.levels[level].m_letter_found = letters.M
	save_data.levels[level].m_letter_found = letters.A
	save_data.levels[level].x_letter_found = letters.X
	save_data.levels[level].completed = true
	# remove chapter_ to get the number
	save_data.current_level = level.substr(8, level.length()).to_int() + 1
