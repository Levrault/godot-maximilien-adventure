extends Motion


func enter(host: Carniplant) -> void:
	host.get_node("AnimationPlayer").play("Attack")


func exit(host: Carniplant) -> void:
	assert(host is Enemy)
	$HitDamageZone.set_monitoring(false)
	$CrouchDamageZone.set_monitoring(false)


func _on_Animation_finished(anim_name: String, host: Carniplant) -> void:
	assert(anim_name == "Attack")
	host.get_node("CooldownTimer").start()
	host.can_attack = false
	emit_signal("finished", "Idle")
