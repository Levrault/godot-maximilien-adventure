extends Motion

onready var stream: Resource = load('res://sound/general-sounds/Interactions/sfx_sounds_interaction1.wav')

func enter(host: Player) -> void:
	host.get_node('AnimationPlayer').play('Idle')
	play_sound(host, stream, rng.randf_range(0.95, 1.15))
	host.snap_enable = true
	host.velocity.x = 0
	DoorManager.enter_door()


#warning-ignore:unused_argument
func update(host: Player, delta: float):
	if not host.can_open_door:
		emit_signal('finished', 'Idle')