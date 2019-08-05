extends Node2D

signal score_changed(new_score)
signal max_score_changed(new_max_score)

var score: int = 0


func improve_score(value: int) -> void:
	score += value
	emit_signal('score_changed', score)


func init_max_score(value: int) -> void:
	emit_signal('max_score_changed', value)