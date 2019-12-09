extends InAir

var buffer_counter: int = 0 # initialize the buffer's counter
const BUFFER_MAX: int = 4 	# amount of frame to allow buffer

func enter(host: Player) -> void:
	host.get_node('AnimationPlayer').play('Fall')


func exit(host: Player) -> void:
	buffer_counter = 0


func handle_input(host: Player, event: InputEvent) -> InputEvent:
	if event.is_action_pressed('jump'):
		buffer_counter = BUFFER_MAX
	return .handle_input(host, event)


#warning-ignore:unused_argument
func update(host: Player, delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	update_look_direction(host, input_direction)
	move(host, input_direction, host.speed, host.acceleration)
	
	# decrease buffer
	buffer_counter -= 1
	
	if host.in_cart:
		emit_signal('finished', 'InCart')

	if host.is_grounded:
		if buffer_counter > 0:
			emit_signal('finished', 'Jump')
		else:
			emit_signal('finished', 'Landing')