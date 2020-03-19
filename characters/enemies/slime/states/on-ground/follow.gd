extends SlimeOnGround


func _on_Player_entered(body: Player, host: Slime) -> void:
	emit_signal("finished", "Attack")


func enter(host: Slime) -> void:
	.enter(host)
	host.get_node("AnimationPlayer").play("Move")


#warning-ignore:unused_argument
func update(host: Slime, delta: float) -> void:
	if not host.has_target:
		emit_signal("finished", "Retreat")
	else:
		follow(host)


func follow(host: Slime) -> void:
	var target_direction = (host.target_position - host.position).normalized()
	update_look_direction(host, Vector2(int(round(target_direction.x)), 0))
	move(host, target_direction, SPEED, ACCELERATION)
