extends OnMove


func enter(host: Character) -> void:
	host.get_node("AnimationPlayer").play("Run")
	for particule in get_children():
		particule.show()
	.enter(host)


func exit(host: Character) -> void:
	for particule in get_children():
		particule.emitting = false
		particule.hide()


# @emit finished(Walk)
func handle_input(host: Player, event: InputEvent) -> InputEvent:
	if event.is_action_released("run"):
		emit_signal("finished", "Walk")

	return .handle_input(host, event)
