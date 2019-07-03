extends OnGround


func enter(host) -> void:
	host.get_node('AnimationPlayer').play('Idle')
	host.snap_enable = true
	host.velocity.x = 0


func exit(host) -> void:
	host.snap_enable = false


#warning-ignore:unused_argument
#warning-ignore:unused_argument
func update(host, delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	if input_direction.x:
		if Input.is_action_pressed('run'):
			emit_signal('finished', 'Run')
		else:
			emit_signal('finished', 'Walk')

	if not host.is_grounded:
		emit_signal('finished', 'Fall')
