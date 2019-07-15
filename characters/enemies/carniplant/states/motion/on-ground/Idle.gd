extends OnGround


func enter(host: Enemy) -> void:
	host.get_node('AnimationPlayer').play('Idle')
	$IdleDamageZone.set_monitoring(true)


func exit(host: Enemy) -> void:
	$IdleDamageZone.set_monitoring(false)


func update(host: Enemy, delta: float) -> void:
	if host.has_target and host.can_attack:
		emit_signal('finished', 'Attack')


#func follow(host: Enemy) -> void:
#	var target_direction = (host.target_position - host.position).normalized() 
##	update_look_direction(host, Vector2(int(round(target_direction.x)), 0), -1)
#
#	if host.position.distance_to(host.target_position) <= host.ATTACK_RANGE and host.can_attack:
#		print('Attack')
#		emit_signal('finished', 'Attack')