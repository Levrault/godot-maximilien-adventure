# Main Menu
extends Control

var selected_profile := "profile0"
var selected_profile_node = null


func _ready() -> void:
	# Profile Settings
	$ProfileSettings/Container/ContinueBtn.connect("pressed", self, "_on_Continue_pressed")
	$ProfileSettings/Container/DeleteBtn.connect(
		"pressed", $AnimationPlayer, "play", ["Validation"]
	)
	$ProfileSettings/Container/ReturnProfileBtn.connect("pressed", self, "_on_Cancel_pressed")

	#Validation modal
	$Validation/Container/YesBtn.connect("pressed", self, "_on_Delete_profile_pressed")
	$Validation/Container/NoBtn.connect("pressed", $AnimationPlayer, "play", ["ValidationNo"])

	for profile in $Profiles.get_children():
		profile.connect("profile_selected", self, "_on_Profile_selected")

	MusicManager.change_music("menu")

	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


# Enable sound with AnimationPlayer
func _toggle_button_sound(toggled: bool) -> void:
	UiManager.play_sound = toggled


# @signal profile_selected
func _on_Profile_selected(text: String, profile: String, node: String) -> void:
	$AnimationPlayer.play("ProfileSelected")
	$ProfileSettings/PixelLabel.text = text
	selected_profile = profile
	selected_profile_node = node


# Load overworld with current profile
# @signal pressed
func _on_Continue_pressed() -> void:
	ProgressionManager.path = selected_profile
	ProgressionManager.load_game()
	SceneManager.goto_scene("res://interfaces/overworld/OverWorld.tscn")


# Un-select profile
# @signal pressed
func _on_Cancel_pressed() -> void:
	$AnimationPlayer.play("ProfileSelectedNo")
	get_node("Profiles/%s" % [selected_profile_node]).focus()


# Delete a profile and reload scene
# @signal pressed
func _on_Delete_profile_pressed() -> void:
	ProgressionManager.delete_save_game(selected_profile)
	get_tree().change_scene("res://interfaces/menu/Menu.tscn")
