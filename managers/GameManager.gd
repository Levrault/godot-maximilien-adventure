extends Node

signal player_life(life)
signal player_score(score)

var player_life: int = 3
var player_score: int = 0

var player_is_alive: bool = true

func _ready():
	pass # Replace with function body.


func player_gain_life() -> void:
	player_life += 1
	emit_signal('player_life', player_life)


func player_loose_life() -> void:
	player_life -= 1
	emit_signal('player_life', player_life)