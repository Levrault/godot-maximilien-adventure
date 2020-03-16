extends Motion


func enter(host: Carniplant) -> void:
	host.get_node("AnimationPlayer").play("Attack")


func exit(host: Carniplant) -> void:
	$HitDamageZone.set_monitoring(false)
	host.can_attack = false


func _on_Animation_finished(anim_name: String, host: Carniplant) -> void:
	assert(anim_name == "Attack")
	emit_signal("finished", "Idle")
