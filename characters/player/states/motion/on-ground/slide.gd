extends OnGround


func enter(host: Character) -> void:
	host.get_node('AnimationPlayer').play('Slide')
	host.snap_enable = false


func exit(host: Character) -> void:
	host.snap_enable = false


#warning-ignore:unused_argument
func update(host: Character, delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	if not input_direction:
		input_direction = Vector2(1, 0)
	move(host, input_direction, host.speed, host.acceleration)


func _on_Animation_finished(anim_name: String, host: Player) -> void:
	assert anim_name == 'Slide'
	emit_signal('finished', 'Idle')