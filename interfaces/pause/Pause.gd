# Pause Menu, should stop every action to let the player
# choose in the menu.
extends Control


func _ready() -> void:
	visible = false
	$Background/VBoxContainer/Resume.connect("pressed", self, "_on_Resume_pressed")


# Listen to pause input.
# @param {InputEvent} event
func _input(event: InputEvent) -> void:
	if not PlayerManager.player.input_enable:
		return
	if event.is_action_pressed("pause"):
		if not get_tree().paused:
			$AnimationPlayer.play("TransitionIn")
		else:
			$AnimationPlayer.play("TransitionOut")


# Show/hide player ui with AnimationPlayer
# @emit ui_player_hide OR ui_player_show
# @emit ui_intro_start OR ui_intro_hide
# @param {bool} visible
func _hide_other_ui(visible: bool) -> void:
	UiManager.player_ui(visible)
	UiManager.show_intro_title(visible)


# Pause setup with AnimationPlayer
# @param {bool} paused
func _set_pause(paused: bool) -> void:
	get_tree().paused = paused


# Resume button.
# @signal pressed
func _on_Resume_pressed() -> void:
	$AnimationPlayer.play("TransitionOut")


# Enable sound with AnimationPlayer
func _toggle_button_sound(toggled: bool) -> void:
	UiManager.play_sound = toggled
