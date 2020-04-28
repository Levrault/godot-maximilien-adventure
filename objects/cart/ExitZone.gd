# Exit zone of a level
extends Area2D

export (String) var next_level := ""


func _ready() -> void:
	connect("body_entered", self, "_on_Body_enter")


# @signal body_entered
# @param {Player} body
func _on_Body_enter(body: Player) -> void:
	if body.can_exit_level and body.in_cart:
		UiManager.show_score()
		SceneManager.scene_path = next_level
