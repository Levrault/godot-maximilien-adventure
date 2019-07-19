extends Node

var player_state: String = 'SETUP' setget set_player_state, get_player_state
var player_velocity: Vector2 = Vector2.ZERO setget set_player_velocity, get_player_velocity
var player_respawn: Vector2 = Vector2.ZERO setget set_player_respawn, get_player_respawn


func set_player_state(state: String) -> void:
	player_state = state


func get_player_state() -> String:
	return player_state


func set_player_velocity(velocity: Vector2) -> void:
	player_velocity = velocity


func get_player_velocity() -> Vector2:
	return player_velocity


func set_player_respawn(respawn: Vector2) -> void:
	player_respawn = respawn


func get_player_respawn() -> Vector2:
	return player_respawn