extends OnGround


func enter(host: Carniplant) -> void:
	host.get_node("AnimationPlayer").play("Idle")
	host.get_node("CooldownTimer").start()


func update(host: Carniplant, delta: float) -> void:
	if host.has_target and host.can_attack:
		emit_signal("finished", "Attack")
