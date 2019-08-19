extends Motion

onready var stream: Resource = load('res://sound/general-sounds/Interactions/sfx_sounds_interaction1.wav')

func enter(host: Player) -> void:
	host.get_node('AnimationPlayer').play('Idle')

	play_sound(host, stream, rng.randf_range(0.95, 1.15))
	
	# set camera zoom
	CameraManager.zoom_in(host.chest_position)
	
	# open the chest
	InteractionsManager.open_chest()
	
	# update player direction to look at the npc
	var direction = (host.chest_position - host.position).normalized()
	update_look_direction(host, Vector2(int(round(direction.x)), 0))
	host.snap_enable = true
	host.velocity.x = 0


func exit(host: Player) -> void:
	host.snap_enable = false
	CameraManager.zoom_out()


#warning-ignore:unused_argument
func update(host: Player, delta: float):
	if not host.can_open_chest:
		emit_signal('finished', 'Idle')