"""
Manage ui display
"""
extends Node

signal ui_loose_life_show
signal ui_loose_life_hide
signal ui_game_over_show
signal player_ui_hide
signal player_ui_show


"""
Manager player ui visibility
@param {bool} visibility
@emit player_ui_show OR player_ui_hide
"""
func player_ui(visiblity: bool) -> void:
	if (visiblity):
		emit_signal("player_ui_show")
	else:
		emit_signal("player_ui_hide")


"""
@emit ui_loose_life_show
@emit player_ui_hide
"""
func show_lost_a_life_screen() -> void:
	emit_signal("player_ui_hide")
	emit_signal("ui_loose_life_show")


"""
@emit ui_loose_life_hide
@emit player_ui_show
"""
func hide_lost_a_life_screen() -> void:
	emit_signal("ui_loose_life_hide")
	emit_signal("player_ui_show")


"""
@emit ui_game_over_show
@emit player_ui_hide
"""
func show_game_over() -> void:
	emit_signal("player_ui_hide")
	emit_signal("ui_game_over_show")