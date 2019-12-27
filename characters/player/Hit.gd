"""
Manage player state when getting hit
"""
extends Node2D

onready var stream: Resource = load("res://sound/general-sounds/simple-damage-sounds/sfx_damage_hit1.wav")
onready var FlashPlayer: AnimationPlayer = get_parent().get_node("FlashPlayer")
onready var AudioStream: AudioStreamPlayer2D = get_parent().get_node("AudioStreamPlayer")


"""
Player hit animation or kill the player
@param {Player} host
@param {Bool} is_alive
"""
func get_hit(host: Player, is_alive: bool) -> void:
	if is_alive:
		FlashPlayer.play("Flash")
		if ProjectSettings.get_setting("Debug/sound"):
			AudioStream.stream = stream
			AudioStream.play()
	else:
		host._change_state("Death")