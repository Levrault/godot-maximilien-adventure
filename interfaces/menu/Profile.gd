"""
Manage load and display of menu profile information
"""
extends Control

export(String) var profile_save = 'profile0'
const MAX_CHARACTER_VISIBLE := 26
var profile_name = ''
var profile_level = ''
var is_new_profile := true


func _ready() -> void:
	$Parchment/PixelButton.connect("pressed", self, "_on_Button_pressed")


"""
Load creator if the profile doesn't exist or
load the overworld
"""
func _on_Button_pressed() -> void:
	if is_new_profile:
		ProgressionManager.path = profile_save
		get_tree().change_scene("res://interfaces/menu/ProfileCreator.tscn")
	else:
		ProgressionManager.load_game(profile_save)
		get_tree().change_scene("res://interfaces/overworld/OverWorld.tscn")


"""
Set new profile text
"""
func new_profile() -> void:
	is_new_profile = true
	$Parchment/PixelButton.text = TranslationServer.translate("MENU_NEW_ADVENTURE")


"""
@param {String} name
@param {int} level
"""
func existing_profile(name: String, level: int) -> void:
	is_new_profile = false
	profile_name = name
	profile_level = level
	var level_text := TranslationServer.translate("UI_PROFILE_CHAPTER")
	$Parchment/PixelButton.text = "%s - %s" % [profile_name, level_text % level]


"""
Focus on first button
"""
func focus() -> void:
	$Parchment/PixelButton.grab_focus()

