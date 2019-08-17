extends Node

signal start_dialogue
signal next_dialogue
signal end_dialogue
signal open_chest
signal chest_opened


func start_dialogue() -> void:
	emit_signal('start_dialogue')


func next_dialogue() -> void:
	emit_signal('next_dialogue')


func end_dialogue() -> void:
	emit_signal('end_dialogue')


func open_chest() -> void:
	emit_signal('open_chest')


func chest_opened() -> void:
	emit_signal('chest_opened')