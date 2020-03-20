# Manage player state when getting hit
extends Node2D

export (Resource) var stream = null

onready var FlashPlayer: AnimationPlayer = get_parent().get_node("FlashPlayer")
onready var AudioStream: AudioStreamPlayer2D = get_parent().get_node("AudioStreamPlayer")


# Player hit animation or kill the player
# @param {Player} host
# @param {Bool} is_alive
func get_hit(host: Player, is_alive: bool) -> void:
	if is_alive:
		FlashPlayer.play("Flash")
		assert(stream != null)
		AudioStream.stream = stream
		AudioStream.play()
	elif host.current_state.get_name() != "Death":
		host._change_state("Death")
