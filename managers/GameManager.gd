extends Node

signal player_life(life)
#signal player_score(score)
signal player_respawn_last_checkpoint

var player_life: int = 3
#var player_score: int = 0

#var player_is_alive: bool = true

var last_checkpoint: Vector2 = Vector2.ZERO setget set_new_checkpoint, get_last_checkpoint


func player_gain_life() -> void:
	player_life += 1
	emit_signal('player_life', player_life)


func player_loose_life() -> void:
	player_life -= 1
	emit_signal('player_life', player_life)


func set_new_checkpoint(checkpoint: Vector2) -> void:
	if last_checkpoint != checkpoint:
		last_checkpoint = checkpoint


func get_last_checkpoint() -> Vector2:
	return last_checkpoint