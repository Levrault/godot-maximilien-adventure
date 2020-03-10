extends InAir

export (float) var MAX_JUMP_FORCE := 550.0
export (float) var MIN_JUMP_FORCE := 350.0
export (Resource) var stream = null


func enter(host: Player) -> void:
	host.get_node("AnimationPlayer").play("Jump")

	assert(stream != null)
	play_sound(host, stream, rng.randf_range(0.95, 1.15))

	host.snap_enable = false
	host.has_coyote_jump = true
	if host.controlled_jump:
		host.velocity.y = -MAX_JUMP_FORCE


func exit(host: Player) -> void:
	host.controlled_jump = true


func handle_input(host: Player, event: InputEvent) -> InputEvent:
	if event.is_action_released("jump"):
		if abs(host.velocity.y) > MIN_JUMP_FORCE:
			host.velocity.y = -MIN_JUMP_FORCE

	return .handle_input(host, event)


# @emit finished(JumpMidAir)
func update(host: Player, delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	update_look_direction(host, input_direction)

	if host.speed == 0 and input_direction:
		host.speed = SPEED
		host.acceleration = ACCELERATION

	move(host, input_direction, host.speed, host.acceleration)
	if host.velocity.y > 0:
		emit_signal("finished", "JumpMidAir")
