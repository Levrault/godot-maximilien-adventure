extends Motion
class_name OnGround


# @emit finished(Jump)
# @emit finished(Talk)
# @emit finished(OpenDoor)
# @emit finished(OpenChest)
func handle_input(host: Player, event: InputEvent) -> InputEvent:
	if event.is_action_pressed("jump"):
		emit_signal("finished", "Jump")
	elif event.is_action_pressed("action"):
		if host.can_talk:
			host.is_waiting_for_next_dialogue = true
			emit_signal("finished", "Talk")
		elif host.can_open_door:
			emit_signal("finished", "OpenDoor")
		elif host.can_open_chest:
			emit_signal("finished", "OpenChest")
	return .handle_input(host, event)
