extends State

export (Resource) var stream = null


func enter(host: Player) -> void:
	host.get_node("FlashPlayer").play("Flash")
	play_sound(host, stream, rng.randf_range(0.95, 1.15))
	host.is_invincible = true
	if host.knockback_force != Vector2.ZERO:
		host.get_node("AnimationPlayer").play("Fall")
		host.velocity.x = host.knockback_force.x * host.look_direction.x * -1
		host.velocity.y = -host.knockback_force.y
		host.snap_enable = false


func exit(host) -> void:
	host.knockback_force = Vector2.ZERO
	host.snap_enable = true


# @signal animation_finished
func _on_Animation_finished(anim_name: String, host: Character) -> void:
	host.is_invincible = false
	if host.is_grounded:
		emit_signal("finished", "Idle")
	else:
		emit_signal("finished", "Fall")
