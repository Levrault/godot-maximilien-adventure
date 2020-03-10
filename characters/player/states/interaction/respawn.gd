extends State
class_name Respawn


func enter(host: Player) -> void:
	host.get_node("AnimationPlayer").play("Respawn")


func exit(host: Player) -> void:
	host.gravity_enable = true
	host.velocity = Vector2.ZERO
	host.is_invincible = false


# @signal animation_finished


# # @emit finished(Idle)
func _on_Animation_finished(anim_name: String, host: Character) -> void:
	assert(anim_name == "Respawn")
	emit_signal("finished", "Idle")
