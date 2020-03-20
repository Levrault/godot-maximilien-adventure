extends SlimeOnGround

export (Resource) var stream = null
var velocity := Vector2(140, 0)
var move := false


func _on_Player_entered(body: Player, host: Slime) -> void:
	emit_signal("finished", "GettingHit")
	play_sound(host, stream, rng.randf_range(0.95, 1.15))


func _on_Timeout(host: Slime) -> void:
	host.get_node("AnimationPlayer").play("Retreat")
	move = true


func enter(host: Slime) -> void:
	.enter(host)
	host.get_node("AnimationPlayer").play("Idle")
	$Timer.connect("timeout", self, "_on_Timeout", [host])

	velocity = Vector2(SPEED * host.look_direction.x * -1, 0)
	host.velocity.x = velocity.x * -1
	$Timer.start()


func exit(host: Slime) -> void:
	.exit(host)
	$Timer.stop()
	$Timer.disconnect("timeout", self, "_on_Timeout")
	move = false


func update(host: Slime, delta: float) -> void:
	if host.has_target:
		emit_signal("finished", "Follow")
	if not move:
		host.velocity = Vector2.ZERO
		return
	host.velocity = velocity
