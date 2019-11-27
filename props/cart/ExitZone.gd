extends Area2D

export (String) var next_level := '' setget set_next_level, get_next_level


func _ready() -> void:
	connect('body_entered', self, '_on_Body_enter')


func _on_Body_enter(body: Player) -> void:
	assert body is Player
	print(body.can_exit_level)
	if body.can_exit_level:
		print(next_level)
		LevelManager.goto_scene(next_level)


func set_next_level(level: String) -> void:
	next_level = level


func get_next_level() -> String:
	return next_level
	