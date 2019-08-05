extends Node

signal player_life(life)
signal score_changed(score)
signal max_score_changed(score)
signal player_respawn_last_checkpoint

var player_life: int = 3
var max_score: int = 0 setget set_max_score, get_max_score
var score: int = 0 setget set_score,  get_score

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
	

func set_max_score(new_max_score: int) -> void:
	max_score = new_max_score
	emit_signal('max_score_changed', max_score)


func get_max_score() -> int:
	return max_score


func set_score(value: int) -> void:
	score += value
	emit_signal('score_changed', score)


func get_score() -> int:
	return score