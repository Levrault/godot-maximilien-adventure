extends OnGround


func enter(host) -> void:
	host.get_node('AnimationPlayer').play('Landing')
	host.snap_enable = true
	host.velocity.x = 0


#warning-ignore:unused_argument
#warning-ignore:unused_argument
func update(host, delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	if input_direction.x:
		if Input.is_action_pressed('run'):
			emit_signal('finished', 'Run')
		else:
			emit_signal('finished', 'Walk')


func _on_Animation_finished(anim_name: String, host: Player) -> void:
	emit_signal('finished', 'Idle')