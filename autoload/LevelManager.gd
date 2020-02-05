extends Node

signal limit_disabled


func disable_limit_collision() -> void:
	emit_signal("limit_disabled")
