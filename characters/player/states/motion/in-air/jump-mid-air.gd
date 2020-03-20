extends InAir


func enter(host) -> void:
	host.get_node("AnimationPlayer").play("JumpMidAir")


func update(host: Player, delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	update_look_direction(host, input_direction)
	move(host, input_direction, host.speed, host.acceleration)


# @signal animation_finished
func _on_Animation_finished(anim_name: String, host: Player) -> void:
	emit_signal("finished", "Fall")
