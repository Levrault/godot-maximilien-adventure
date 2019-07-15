extends OnGround

func enter(host: Player) -> void:
	host.get_node('AnimationPlayer').play('Slide')
	host._toggle_collision_shape()
	host.snap_enable = false


func exit(host: Player) -> void:
	host.snap_enable = false
	host._toggle_collision_shape()


#warning-ignore:unused_argument
func update(host: Player, delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	if not input_direction:
		input_direction = Vector2(1, 0)
	move(host, input_direction, host.speed * 1.75, host.acceleration)


func _on_Animation_finished(anim_name: String, host: Player) -> void:
	assert anim_name == 'Slide'
	assert host is Player
	emit_signal('finished', 'Idle')