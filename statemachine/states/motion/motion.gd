# Use to compute movement of a character
extends State
class_name Motion

# pixels/sec
#warning-ignore:unused_class_variable
export (float) var SPEED := 125.0
#warning-ignore:unused_class_variable
export (float) var ACCELERATION := 0.25


# Watch input to convert pressed action to a Vector
# Left will equal -1
# Right will equal 1
# Up will equal -1
# Down will be 1
# @return Vector2
func get_input_direction() -> Vector2:
	var input_direction: Vector2 = Vector2.ZERO
	input_direction.x = (
		int(Input.is_action_pressed("move_right"))
		- int(Input.is_action_pressed("move_left"))
	)
	input_direction.y = (
		int(Input.is_action_pressed("move_down"))
		- int(Input.is_action_pressed("move_up"))
	)
	return input_direction


# Scale node based on the current look directino of the character
# @param {Character} host
# @param {Vector2} direction
func update_look_direction(host: Character, direction: Vector2) -> void:
	if direction and host.look_direction != direction:
		host.look_direction = direction
	if not direction.x in [-1, 1]:
		return
	host.get_node("Sprite").set_scale(Vector2(direction.x, 1))
	host.get_node("States").set_scale(Vector2(direction.x, 1))


# Change character's velocity to make it move
# @param {Character} host
# @param {Vector2} input_direction
# @param {float} speed
# @param {float} acceleration
func move(host: Character, input_direction: Vector2, speed: float, acceleration: float) -> void:
	if host.controllable_movement:
		host.velocity.x = (
			lerp(host.velocity.x, host.look_direction.x * speed, acceleration)
			if input_direction
			else 0
		)
