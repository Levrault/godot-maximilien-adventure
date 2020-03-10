extends OnMove


func enter(host: Character) -> void:
	host.get_node("AnimationPlayer").play("Walk")
	.enter(host)


# @emit finished(Run)
func handle_input(host: Player, event: InputEvent) -> InputEvent:
	if event.is_action_pressed("run"):
		emit_signal("finished", "Run")

	return .handle_input(host, event)
