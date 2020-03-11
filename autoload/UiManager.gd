# Manage ui display
extends Node

signal ui_loose_life_show
signal ui_loose_life_hide
signal ui_game_over_show
signal ui_show_score
signal ui_player_hide
signal ui_player_show
signal ui_intro_start
signal ui_intro_show
signal ui_intro_hide

var play_sound := true


# Manager player ui visibility
# @param {bool} visibility
# @emit ui_player_show OR ui_player_hide
func player_ui(visiblity: bool) -> void:
	if visiblity:
		emit_signal("ui_player_show")
	else:
		emit_signal("ui_player_hide")


# @emit ui_player_hide
# @emit ui_loose_life_show
func show_lost_a_life_screen() -> void:
	emit_signal("ui_player_hide")
	emit_signal("ui_intro_hide")
	emit_signal("ui_loose_life_show")


# @emit ui_player_show
# @emit ui_loose_life_hide
func hide_lost_a_life_screen() -> void:
	emit_signal("ui_loose_life_hide")
	emit_signal("ui_intro_show")
	emit_signal("ui_player_show")


# @emit ui_player_hide
# @emit ui_game_over_show
func show_game_over() -> void:
	emit_signal("ui_player_hide")
	emit_signal("ui_intro_hide")
	emit_signal("ui_game_over_show")


# @emit ui_player_hide
# @emit ui_show_score
func show_score() -> void:
	emit_signal("ui_player_hide")
	emit_signal("ui_intro_hide")
	emit_signal("ui_show_score")


# @emit ui_intro_start
func start_intro_title() -> void:
	emit_signal("ui_intro_start")


# @emit ui_intro_start
func show_intro_title(visibility: bool) -> void:
	if visibility:
		emit_signal("ui_intro_show")
	else:
		emit_signal("ui_intro_hide")
