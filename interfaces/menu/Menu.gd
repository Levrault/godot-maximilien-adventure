"""
Main Menu
"""
extends Control

var selected_profile := "profile0"
var selected_profile_node = null


func _ready() -> void:
	for profile in $Profiles.get_children():
		profile.connect("profile_selected", self, "_on_Profile_selected")


"""
@signal profile_selected
"""
func _on_Profile_selected(text: String, profile: String, node: String) -> void:
	$AnimationPlayer.play("ProfileSelected")
	$ProfileSettings/PixelLabel.text = text
	selected_profile = profile
	selected_profile_node = node
