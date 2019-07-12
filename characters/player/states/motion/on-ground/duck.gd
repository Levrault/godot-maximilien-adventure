extends OnGround

func enter(host: Player) -> void:
	host.get_node('AnimationPlayer').play('Duck')
	host._toggle_collision_shape()
	.enter(host)


func exit(host: Player) -> void:
	host._toggle_collision_shape()


func handle_input(host: Player, event: InputEvent) -> InputEvent:
	if event.is_action_released('crouch'):
		emit_signal('finished', 'Idle')
		
	return .handle_input(host, event)