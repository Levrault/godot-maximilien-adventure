extends Motion

onready var stream: Resource = load('res://sound/general-sounds/interactions/sfx_sounds_interaction1.wav')

func enter(host: Player) -> void:
	host.get_node('AnimationPlayer').play('Idle')
	
	play_sound(host, stream, rng.randf_range(0.95, 1.15))
	
	# set camera zoom
	CameraManager.zoom_in(host.npc_to_talk_position)
	
	# update player direction to look at the npc
	var direction = (host.npc_to_talk_position - host.position).normalized()
	update_look_direction(host, Vector2(int(round(direction.x)), 0))
	host.snap_enable = true
	host.velocity.x = 0
	
	# start the dialogue
	DialogueManager.start_dialogue()



func exit(host: Player) -> void:
	host.snap_enable = false
	host.can_talk = false
	CameraManager.zoom_out()


#warning-ignore:unused_argument
func update(host, delta: float):
	if not host.is_waiting_for_next_dialogue:
		emit_signal('finished', 'Idle')


func handle_input(host: Player, event: InputEvent) -> InputEvent:
	if event.is_action_pressed('action') and host.is_waiting_for_next_dialogue:
		DialogueManager.next_dialogue()
	return .handle_input(host, event)