"""
Manage load and display of menu profile information
"""
extends Control

signal profile_selected(text, profile, node)

export(String) var profile_save = 'profile0'
const MAX_CHARACTER_VISIBLE := 26
var is_new_profile := true


func _ready() -> void:
	$Parchment/PixelButton.connect("pressed", self, "_on_Button_pressed")


"""
Load creator if the profile doesn't exist or
Show profile options
@emit profile_slected
"""
func _on_Button_pressed() -> void:
	if is_new_profile:
		ProgressionManager.path = profile_save
		get_tree().get_root().get_node("Menu").queue_free()
		get_tree().change_scene("res://interfaces/menu/ProfileCreator.tscn")
	else:
		print(get_name())
		emit_signal("profile_selected", $Parchment/PixelButton.text, profile_save, get_name())


"""
Set new profile text
"""
func new_profile() -> void:
	is_new_profile = true
	$Parchment/PixelButton.text = TranslationServer.translate("UI_NEW_GAME")


"""
@param {String} name
@param {int} level
"""
func existing_profile(name: String, level: int) -> void:
	is_new_profile = false
	var level_text := TranslationServer.translate("UI_PROFILE_CHAPTER")
	$Parchment/PixelButton.text = "%s - %s" % [name, level_text % level]


"""
Focus on first button
"""
func focus() -> void:
	$Parchment/PixelButton.grab_focus()

