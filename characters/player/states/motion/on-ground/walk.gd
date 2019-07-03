extends OnMove

func enter(host: Character) -> void:
	host.get_node('AnimationPlayer').play('Walk')
	.enter(host)


func handle_input(host: Player, event: InputEvent) -> InputEvent:
	if event.is_action_pressed('run'):
		emit_signal('finished', 'Run')
	elif event.is_action_released('run'):
		emit_signal('finished', 'Walk')
		
	return .handle_input(host, event)