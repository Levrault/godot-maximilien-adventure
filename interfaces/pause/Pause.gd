"""

"""
extends Control

func _ready() -> void:
	visible = false
	$Background/VBoxContainer/Resume.connect('pressed', self, '_on_Resume_pressed')
	$Background/VBoxContainer/OverWorld.connect('pressed', self, '_on_OverWorld_pressed')
	$Background/VBoxContainer/Settings.connect('pressed', self, '_on_Settings_pressed')
	$Background/VBoxContainer/Quit.connect('pressed', self, '_on_Quit_pressed')


func _input(event: InputEvent) -> void:
	if event.is_action_pressed('pause'):
		var new_pause_state := !get_tree().paused
		get_tree().paused = new_pause_state
		UiManager.player_ui(!new_pause_state)
		if new_pause_state: 
			$AnimationPlayer.play("Transition")
		else:
			$AnimationPlayer.play_backwards("Transition")


func _on_Resume_pressed() -> void:
	get_tree().paused = false
	$AnimationPlayer.play_backwards("Transition")


func _on_OverWorld_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene("res://interfaces/overworld/OverWorld.tscn")


func _on_Settings_pressed() -> void:
	pass


func _on_Quit_pressed() -> void:
	pass