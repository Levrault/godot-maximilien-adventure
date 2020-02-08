"""
Manager player state
"""
extends Node
signal player_retry_checkpoint
signal player_input_enable


"""
@emit player_input_enable
"""
func input_enable() -> void:
	emit_signal("player_input_enable")


"""
@emit player_retry_checkpoint
"""
func retry_checkpoint() -> void:
	emit_signal("player_retry_checkpoint")
