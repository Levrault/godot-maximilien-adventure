extends Node

var player: Player = null setget set_player, get_player


func get_player() -> Player:
	return player


func set_player(new_player: Player) -> void:
	player = new_player
