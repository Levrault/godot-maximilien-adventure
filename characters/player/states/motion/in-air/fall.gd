extends InAir


func enter(host: Player) -> void:
	host.get_node('AnimationPlayer').play('Fall')


#warning-ignore:unused_argument
func update(host: Player, delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	update_look_direction(host, input_direction)

	move(host, input_direction, host.speed, host.acceleration)

	if host.is_grounded:
		emit_signal('finished', 'Landing')