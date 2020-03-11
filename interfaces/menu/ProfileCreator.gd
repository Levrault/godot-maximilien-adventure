# Manage profile creator with a virtual keyboard
extends Control

signal max_character(is_reached)

const MAX_CHARACTER := 10
var limit_reached := false


func _ready():
	connect("max_character", $ProfileName, "_on_Max")
	$Keyboard.connect("keydown", self, "_on_Name_change")
	$Keyboard.connect("keyup", self, "_has_reached_character_limit")
	$Actions/ParchmentScrollOpaque/EraseButton.connect("pressed", self, "_on_Name_erase")
	$Actions/Banner/EndButton.connect("pressed", self, "_on_End")


# Add a new letter when virtual keyboard key are pressed
# @param {String} letter
func _on_Name_change(letter: String) -> void:
	if not limit_reached:
		$ProfileName/Name.text += letter
		limit_reached = false


# Check after each keyup if we reached the character limit
# @emit max_character(true)
func _has_reached_character_limit() -> void:
	if $ProfileName/Name.text.length() == MAX_CHARACTER and not limit_reached:
		emit_signal("max_character", true)
		limit_reached = true


# Erase last letter
func _on_Name_erase() -> void:
	var length: int = $ProfileName/Name.text.length()
	var text: String = $ProfileName/Name.text
	if length > 0:
		if length == MAX_CHARACTER:
			emit_signal("max_character", false)
			limit_reached = false
		text.erase(length - 1, length)
		$ProfileName/Name.text = text


# Save the profile name and manage error
func _on_End() -> void:
	if $ProfileName/Name.text.empty():
		$AnimationPlayer.play("NoNameWarning")
		return

	ProgressionManager.create_save_file($ProfileName/Name.text, 1)
	get_tree().change_scene("res://interfaces/menu/Menu.tscn")
