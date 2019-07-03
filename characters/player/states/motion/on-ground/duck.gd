extends OnGround

func enter(host: Character) -> void:
	host.get_node('AnimationPlayer').play('Duck')
	.enter(host)


func handle_input(host: Player, event: InputEvent) -> InputEvent:
	if event.is_action_released('crouch'):
		emit_signal('finished', 'Idle')
		
	return .handle_input(host, event)