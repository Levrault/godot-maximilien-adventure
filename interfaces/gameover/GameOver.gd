extends Control


func _ready():
	visible = false
	UiManager.connect("ui_game_over_show", self, "_on_Show")


"""
Display with transition
"""
func _on_Show() -> void:
	$AnimationPlayer.play("TransitionIn")


"""
Load overworld
"""
func _return_to_overworld() -> void:
	SceneManager.goto_scene("res://interfaces/overworld/OverWorld.tscn")