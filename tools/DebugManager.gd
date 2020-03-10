extends Node

var level_name: String = "Placeholder" setget set_level_name, get_level_name
var player_state: String = "SETUP" setget set_player_state, get_player_state
var player_velocity: Vector2 = Vector2.ZERO setget set_player_velocity, get_player_velocity
var player_respawn: Vector2 = Vector2.ZERO setget set_player_respawn, get_player_respawn
var player: Player = null setget set_player, get_player


func set_level_name(new_name: String) -> void:
	level_name = new_name


func get_level_name() -> String:
	return level_name


func set_player(new_player: Player) -> void:
	player = new_player


func get_player() -> Player:
	return player


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
