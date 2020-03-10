extends State


func enter(host: Character) -> void:
	.enter(host)
	host.is_invincible = true


# @signal animation_finished
func _on_Animation_finished(anim_name: String, host: Character) -> void:
	assert(anim_name == "GettingHit")
	if host.is_alive:
		host.is_invincible = false
		if host.is_grounded:
			emit_signal("finished", "Idle")
		else:
			emit_signal("finished", "Fall")
	else:
		emit_signal("finished", "Death")
