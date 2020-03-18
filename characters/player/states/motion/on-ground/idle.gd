extends OnImmobile

var animationPlayer: AnimationPlayer = null
const TIME_LEFT := 10


func enter(host: Player) -> void:
	if not $LookAroundTimer.is_connected("timeout", self, "_on_LookAroundTimer_timeout"):
		$LookAroundTimer.connect("timeout", self, "_on_LookAroundTimer_timeout")

	animationPlayer = host.get_node("AnimationPlayer")
	animationPlayer.play("Idle")
	$LookAroundTimer.wait_time = TIME_LEFT
	$LookAroundTimer.start()
	host.has_coyote_jump = false
	.enter(host)


func exit(host: Player) -> void:
	.exit(host)
	$LookAroundTimer.stop()


# @emit finished(inCart)
# @emit finished(Run)
# @emit finished(Walk)
# @emit finished(Fall)
func update(host: Player, delta: float) -> void:
	if not host.input_enable:
		return
	if host.in_cart:
		emit_signal("finished", "InCart")
	var input_direction: Vector2 = get_input_direction()
	if input_direction.x:
		if Input.is_action_pressed("run"):
			emit_signal("finished", "Run")
		else:
			emit_signal("finished", "Walk")

	if not host.is_grounded:
		emit_signal("finished", "Fall")


# @signal timeout
func _on_LookAroundTimer_timeout() -> void:
	animationPlayer.play("LookAround")


# @signal animation_finished
func _on_Animation_finished(anim_name: String, host: Player) -> void:
	if anim_name == "LookAround":
		host.get_node("AnimationPlayer").play("Idle")
		$LookAroundTimer.wait_time = TIME_LEFT
		$LookAroundTimer.start()
