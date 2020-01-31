"""
Exit zone of a level
"""
extends Area2D

export (String) var next_level := "" setget set_next_level, get_next_level


func _ready() -> void:
	connect("body_entered", self, "_on_Body_enter")


"""
@signal body_entered
@param {Player} body
"""
func _on_Body_enter(body: Player) -> void:
	assert(body is Player)
	if body.can_exit_level:
		UiManager.show_score()
		SceneManager.scene_path = next_level


"""
setter for level

@param {String} level
"""
func set_next_level(level: String) -> void:
	next_level = level


"""
getter for level

@return {String} level
"""
func get_next_level() -> String:
	return next_level
	
