"""
Score board manager
"""
extends Control

var input_listener := false

func _ready():
	UiManager.connect("ui_show_score", self, "_on_Show")
	$AnimationPlayer.play("DEFAULT")


"""
Start transition
@signal ui_show_score - UIManager
"""
func _on_Show() -> void:
	$AnimationPlayer.play("TransitionIn")


"""
Active input listener
"""
func active_input_listener() -> void:
	input_listener = true


"""
Move carousel or load level
@param {InputEvent} event
"""
func _input(event: InputEvent) -> void:
	if not input_listener:
		return
	if event.is_action_pressed("enter") or event.is_action_pressed("jump")  or event.is_action_pressed("action"):
		SceneManager.goto_scene(SceneManager.scene_path)
