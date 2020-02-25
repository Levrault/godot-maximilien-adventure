"""
Load data
"""
extends OverWorldBtn


func _on_Pressed() -> void:
	._on_Pressed()
	ProgressionManager.path = get_tree().get_current_scene().selected_profile
	ProgressionManager.load_game()
