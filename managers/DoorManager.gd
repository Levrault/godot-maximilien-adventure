extends Node

signal enter_door
signal teleport(position)


var previous_door_position: Vector2 = Vector2.ZERO setget set_previous_door_position


func enter_door() -> void:
	emit_signal('enter_door')


func teleport(position: Vector2) -> void:
	emit_signal('teleport', position)


func set_previous_door_position(position: Vector2) -> void:
	previous_door_position = position


func get_previous_door_position() -> Vector2:
	return previous_door_position 