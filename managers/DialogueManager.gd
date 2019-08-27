extends Node

signal start_dialogue
signal next_dialogue
signal end_dialogue


func start_dialogue() -> void:
	emit_signal('start_dialogue')


func next_dialogue() -> void:
	emit_signal('next_dialogue')


func end_dialogue() -> void:
	emit_signal('end_dialogue')