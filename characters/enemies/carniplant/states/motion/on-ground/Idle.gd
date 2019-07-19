extends OnGround


func enter(host: Enemy) -> void:
	host.get_node('AnimationPlayer').play('Idle')
	$IdleDamageZone.set_monitoring(true)


func exit(host: Enemy) -> void:
	$IdleDamageZone.set_monitoring(false)


#warning-ignore:unused_argument
func update(host: Enemy, delta: float) -> void:
	if host.has_target and host.can_attack:
		emit_signal('finished', 'Attack')