# Slime attack state
extends State

export (Resource) var stream = null


func enter(host: Slime) -> void:
	host.get_node("AnimationPlayer").play("Attack")
	$BouncingZoneBoss.set_collision_mask_bit(1, true)
	play_sound(host, stream, rng.randf_range(0.95, 1.15))
	host.velocity = Vector2(0, 0)


func exit(host: Slime) -> void:
	host.get_node("CooldownTimer").start()
	$BouncingZoneBoss.set_collision_mask_bit(1, false)
	host.can_attack = false


func _on_Animation_finished(anim_name: String, host: Slime) -> void:
	emit_signal("finished", "Idle")
