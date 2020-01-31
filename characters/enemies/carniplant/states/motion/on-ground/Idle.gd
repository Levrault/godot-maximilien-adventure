extends OnGround


func enter(host: Carniplant) -> void:
	host.get_node("AnimationPlayer").play("Idle")
	$IdleDamageZone.set_monitoring(true)


func exit(host: Carniplant) -> void:
	assert(host is Carniplant)
	$IdleDamageZone.set_monitoring(false)


func update(host: Carniplant, delta: float) -> void:
	if host.has_target and host.can_attack:
		emit_signal("finished", "Attack")
