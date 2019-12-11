extends Node

signal ui_loose_life_show
signal ui_loose_life_hide


func show_lost_a_life_screen() -> void:
	emit_signal('ui_loose_life_show')


func hide_lost_a_life_screen() -> void:
	emit_signal('ui_loose_life_hide')