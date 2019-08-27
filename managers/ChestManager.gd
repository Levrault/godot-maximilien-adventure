extends Node

signal active_chest
signal inactive_chest


func active_chest() -> void:
	emit_signal('active_chest')


func inactive_chest() -> void:
	emit_signal('inactive_chest')