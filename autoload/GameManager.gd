# Singleton that manage game setting and state.
extends Node

signal player_life(life)
signal score_changed(score)
signal letter_found(letters)
signal all_letters_found
signal all_diamonds_found
signal notif(message)
signal max_score_changed(score)
signal boss_death

const LIFE := 3

var level := ""
var player_life := LIFE
var max_score := 0 setget set_max_score, get_max_score
var score := 0 setget set_score, get_score
var letters := {"M": false, "A": false, "X": false}
var last_checkpoint := Vector2.ZERO setget set_new_checkpoint, get_last_checkpoint
var player_out_of_bound := false
var compute_fall_damage := true


# Player has found a new life
# @emit player_life(player_life)
func player_reset_life() -> void:
	player_life = LIFE
	emit_signal("player_life", player_life)


# Player has loose a life
# @emit player_life(player_life)
func player_loose_life() -> void:
	player_life -= 1
	emit_signal("player_life", player_life)


# Set new checkpoint
# @param {Vector2} checkpoint
func set_new_checkpoint(checkpoint: Vector2) -> void:
	if last_checkpoint != checkpoint:
		last_checkpoint = checkpoint


# @return {Vector2} checkpoint
func get_last_checkpoint() -> Vector2:
	return last_checkpoint


# Set new max score (by giving the max number of gem availables in the level)
# @emit max_score_changed(max_score)
# @param {int} new_max_score
func set_max_score(new_max_score: int) -> void:
	max_score = new_max_score
	emit_signal("max_score_changed", max_score)


# getter for max_score
# @return {int}
func get_max_score() -> int:
	return max_score


# setter for player's score
# @emit score_changed(score)
# @param {int} value
func set_score(value: int) -> void:
	score += value
	emit_signal("score_changed", score)

	if score >= max_score:
		emit_signal("all_diamonds_found")
		emit_signal("notif", "UI_ALL_DIAMONDS_FOUND")


# resetter for player's score
# @emit score_changed(score)
func reset_score() -> void:
	score = 0
	emit_signal("score_changed", score)


# getter for player's score
# @param {int}
func get_score() -> int:
	return score


# reset dictionary letter to false
func reset_letters() -> void:
	for l in letters:
		letters[l] = false


# Update when player found a new letter
# @emit letter_found(letter)
# @emit all_letters_found
# @emit notif(message)
# @param {String} letter
func find_new_letter(letter: String) -> void:
	letters[letter] = true
	emit_signal("letter_found", letter)
	for l in letters:
		if not letters[l]:
			return

	emit_signal("all_letters_found")
	emit_signal("notif", "UI_ALL_TREASURES_FOUND")


# When boss die in a level
# @emit boss_death
func boss_is_death() -> void:
	emit_signal("boss_death")
