extends Death

onready var stream: Resource = load('res://sound/death-screams/alien/sfx_deathscream_alien2.wav')


func enter(host: Character) -> void:
	play_sound(host, stream)	
	.enter(host)