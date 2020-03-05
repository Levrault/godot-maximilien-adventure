"""
Singleton that manage settings save
"""
extends Node

signal retranslate

const FILE_PATH := "user://settings.save"
const DEFAULT_SETTINGS := {
	"master_volume": 0,
	"music_volume": 0,
	"resolution": "1920x1080",
	"fullscreen": true,
	"locale": "fr"
}
var settings := {}


"""
Update all game settings
"""
func _change_game_settings() -> void:
	# display
	var resolution = settings.resolution.split("x", false)
	OS.set_window_fullscreen(settings.fullscreen)
	OS.set_window_size(Vector2(resolution[0], resolution[1]))
	OS.center_window()

	# translation
	TranslationServer.set_locale(settings.locale)
	emit_signal("retranslate")

	# Audio
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), settings.master_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), settings.music_volume)


""" 
Save player's profile data and settings
"""
func init() -> void:
	var file = File.new()
	if file.file_exists(FILE_PATH):
		print("%s already exist, will be loaded" % [FILE_PATH])
		file.open(FILE_PATH, File.READ)
		settings = parse_json(file.get_line())
		file.close()
		_change_game_settings()
		return

	print("%s does not exist, will be created" % [FILE_PATH])
	file.open(FILE_PATH, File.WRITE)
	file.store_line(to_json(DEFAULT_SETTINGS))
	file.close()

	settings = DEFAULT_SETTINGS
	_change_game_settings()



"""
Save settings
@param {Dictionary} new_settings
"""
func save_settings(new_settings: Dictionary) -> void:
	var file = File.new() 
	file.open(FILE_PATH, File.WRITE_READ)
	var save_data := {
		"master_volume": new_settings.master_volume,
		"music_volume": new_settings.music_volume,
		"resolution": new_settings.resolution,
		"fullscreen": new_settings.fullscreen,
		"locale": new_settings.locale
	}
	file.store_line(to_json(save_data))
	file.close()

	settings = save_data
	_change_game_settings()
	print("update save game for %s" % [FILE_PATH])
