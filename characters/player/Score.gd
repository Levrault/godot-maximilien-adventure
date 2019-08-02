extends Node2D

signal score_changed(new_score)

var score: int = 0

func improve_score(value: int) -> void:
	print(value)
	score += value
	emit_signal('score_changed', score)