extends OnGround


func enter(host: Slime) -> void:
	host.get_node("AnimationPlayer").play("Idle")
	host.velocity.x = 0


#warning-ignore:unused_argument
func update(host: Slime, delta: float) -> void:
	if host.has_target:
		emit_signal("finished", "Follow")
