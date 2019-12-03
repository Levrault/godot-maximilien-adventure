extends Node

signal ui_loose_life_show


func show_lost_a_life_screen() -> void:
	emit_signal('ui_loose_life_show')