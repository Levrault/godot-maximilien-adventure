extends Node2D

onready var stream: Resource = load('res://sound/general-sounds/simple-damage-sounds/sfx_damage_hit1.wav')

onready var FlashPlayer: AnimationPlayer = get_parent().get_node('FlashPlayer')
onready var AudioStream: AudioStreamPlayer2D = get_parent().get_node('AudioStreamPlayer')

func get_hit(host: Player, is_alive: bool) -> void:
	if is_alive:
		FlashPlayer.play('Flash')
		if ProjectSettings.get_setting('Debug/sound'):
			AudioStream.stream = stream
			AudioStream.play()
	else:
#		GameManager.player_loose_life()
		UiManager.show_lost_a_life_screen()
		host.position = GameManager.get_last_checkpoint()
		host.get_node('Health').reset() # TODO: change this when game over screen