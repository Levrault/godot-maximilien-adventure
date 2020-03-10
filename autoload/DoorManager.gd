# Singleton that manage connexion between door and house teleportation
extends Node

signal enter_door
signal teleport(position)

var previous_door_position := Vector2.ZERO setget set_previous_door_position


# @emit enter_door
func enter_door() -> void:
	emit_signal("enter_door")


# @emit teleport(teleport)
# @param {Vector2} position
func teleport(position: Vector2) -> void:
	emit_signal("teleport", position)


# setter for keeping door position
# @param {Vector2} position
func set_previous_door_position(position: Vector2) -> void:
	previous_door_position = position


# getter for keeping door position
# @return {Vector2}
func get_previous_door_position() -> Vector2:
	return previous_door_position
