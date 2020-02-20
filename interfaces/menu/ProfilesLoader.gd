"""
Control all menu profile to load their data
"""
extends VBoxContainer


func _ready():
	for profile in get_children():
		ProgressionManager.load_game(profile.profile_save)
		if ProgressionManager.save_data.empty():
			profile.new_profile()
		else:
			profile.existing_profile(ProgressionManager.save_data.name, ProgressionManager.save_data.current_level)

