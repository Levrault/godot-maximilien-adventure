extends State
class_name Respawn


func enter(host: Player) -> void:
	host.get_node("AnimationPlayer").play("Respawn")
	host.set_collision_layer_bit(1, false)
	host.gravity_enable = true
	host.velocity.x = 0


func exit(host: Player) -> void:
	host.velocity = Vector2.ZERO
	host.is_invincible = false
	host.set_collision_layer_bit(1, true)


# @signal animation_finished
# @emit finished(Idle)
func _on_Animation_finished(anim_name: String, host: Character) -> void:
	emit_signal("finished", "Idle")
