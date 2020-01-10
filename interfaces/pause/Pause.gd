extends Control


func _ready() -> void:
	visible = false
	$VBoxContainer/Resume.connect('pressed', self, '_on_Resume_pressed')
	$VBoxContainer/Quit.connect('pressed', self, '_on_Quit_pressed')


func _input(event: InputEvent) -> void:
	if event.is_action_pressed('pause'):
		var new_pause_state := !get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
		UiManager.player_ui(!new_pause_state)
		get_node('VBoxContainer/Resume').grab_focus()


func _on_Resume_pressed() -> void:
	get_tree().paused = false
	visible = false


func _on_Quit_pressed() -> void:
	get_tree().quit()