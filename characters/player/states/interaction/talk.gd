extends Motion

export (Resource) var stream = null


func _on_Timeout(host: Player) -> void:
	host.can_talk = true
	$Timer.disconnect("timeout", self, "_on_Timeout")


# Freeze player during the dialogue
# @emit camera_zoom_in - CameraManager
# @emit start_dialogue - DialogueManager
func enter(host: Player) -> void:
	assert(stream != null)

	$Timer.connect("timeout", self, "_on_Timeout", [host])
	host.get_node("AnimationPlayer").play("Idle")
	play_sound(host, stream, rng.randf_range(0.95, 1.15))

	# set camera zoom
	CameraManager.focus_in(host.npc_to_talk_position)

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
	$Timer.start()
	CameraManager.focus_out()


#warning-ignore:unused_argument
func update(host, delta: float):
	if not host.is_waiting_for_next_dialogue:
		emit_signal("finished", "Idle")


func handle_input(host: Player, event: InputEvent) -> InputEvent:
	if event.is_action_pressed("action") and host.is_waiting_for_next_dialogue:
		DialogueManager.next_dialogue()
	return .handle_input(host, event)
