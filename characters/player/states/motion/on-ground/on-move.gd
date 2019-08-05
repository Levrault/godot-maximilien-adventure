extends OnGround
class_name OnMove


func enter(host: Character) -> void:
	host.snap_enable = true
	host.speed = SPEED
	host.acceleration = ACCELERATION


func exit(host: Character) -> void:
	host.snap_enable = false


func handle_input(host: Player, event: InputEvent) -> InputEvent:
	if event.is_action_pressed('crouch'):
		emit_signal('finished', 'Slide')
		
	return .handle_input(host, event)


#warning-ignore:unused_argument
func update(host: Character, delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	update_look_direction(host, get_input_direction())
	if not input_direction:
		emit_signal('finished', 'Idle')
	if not host.is_grounded:
		emit_signal('finished', 'Fall')
	
	move(host, input_direction, SPEED, ACCELERATION)