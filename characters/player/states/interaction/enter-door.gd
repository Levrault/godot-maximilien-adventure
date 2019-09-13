extends Motion

onready var stream: Resource = load('res://sound/general-sounds/interactions/sfx_sounds_interaction1.wav')

func enter(host: Player) -> void:
	if not CameraManager.is_connected('camera_transition_finished', self, 'exit'):
		CameraManager.connect('camera_transition_finished', self, 'exit', [host])
	host.get_node('AnimationPlayer').play('Idle')
	play_sound(host, stream, rng.randf_range(0.95, 1.15))
	host.snap_enable = true
	host.velocity.x = 0
	host.is_entering_door = true
	DoorManager.enter_door()


func exit(host: Player) -> void:
	host.is_entering_door = false


#warning-ignore:unused_argument
func update(host: Player, delta: float):
	if not host.is_entering_door:
		emit_signal('finished', 'Idle')