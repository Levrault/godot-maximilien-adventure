extends IAMotion


func exit(host: Character) -> void:
	host.has_hit_player = false


#warning-ignore:unused_argument
func update(host: Character, delta: float) -> void:
	if host.has_target and not host.has_hit_player:
		emit_signal('finished', 'Patrol')
	elif host.position.distance_to(host.starting_position) < .5:
		if host.has_hit_player:
			emit_signal('finished', 'Resting')
		else:
			emit_signal('finished', 'Idle')
	follow(host, host.starting_position)