# Fall with coyote time and jump buffering
# @see https://www.yoyogames.com/blog/544/flynn-advanced-jump-mechanics
extends InAir

# jump buffering
var buffer_counter := 0
const BUFFER_MAX := 8

# coyote time
var coyote_counter := 0
const COYOTE_MAX := 12


func enter(host: Player) -> void:
	host.get_node("AnimationPlayer").play("Fall")
	if not host.has_coyote_jump:
		coyote_counter = COYOTE_MAX


func exit(host: Player) -> void:
	assert(host is Player)
	buffer_counter = 0


func handle_input(host: Player, event: InputEvent) -> InputEvent:
	if event.is_action_pressed("jump"):
		buffer_counter = BUFFER_MAX
		if coyote_counter > 0:
			emit_signal("finished", "Jump")
	return .handle_input(host, event)


func update(host: Player, delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	update_look_direction(host, input_direction)
	move(host, input_direction, host.speed, host.acceleration)

	# decrease buffer
	buffer_counter -= 1

	if host.in_cart:
		emit_signal("finished", "InCart")

	if host.is_grounded:
		if buffer_counter > 0:
			emit_signal("finished", "Jump")
		else:
			emit_signal("finished", "Landing")

	# coyote timer
	coyote_counter -= 1
