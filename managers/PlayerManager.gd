extends Node
signal player_retry_level
signal player_input_enable


func input_enable() -> void:
	emit_signal('player_input_enable')


func retry_level() -> void:
	emit_signal('player_retry_level')