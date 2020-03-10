# Singleton that manage communication between player and dialog creation
extends Node

signal start_dialogue
signal next_dialogue
signal end_dialogue
signal dialogue_audio_start
signal dialogue_audio_stop


# @emit start_dialogue
func start_dialogue() -> void:
	emit_signal("start_dialogue")


# @emit next_dialogue
func next_dialogue() -> void:
	emit_signal("next_dialogue")


# @emit end_dialogue
func end_dialogue() -> void:
	emit_signal("end_dialogue")


# @emit dialogue_audio_start
func dialogue_audio_start() -> void:
	emit_signal("dialogue_audio_start")


# @emit dialogue_audio_stop
func dialogue_audio_stop() -> void:
	emit_signal("dialogue_audio_stop")
