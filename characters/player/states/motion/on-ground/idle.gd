extends OnGround

var animationPlayer: AnimationPlayer = null
const TIME_LEFT := 10

func enter(host: Player) -> void:
	animationPlayer = host.get_node('AnimationPlayer')
	animationPlayer.play('Idle')
	$LookAroundTimer.wait_time = TIME_LEFT
	$LookAroundTimer.start()
	host.snap_enable = true
	host.velocity.x = 0


func exit(host: Player) -> void:
	host.snap_enable = false
	$LookAroundTimer.stop()


func handle_input(host: Player, event: InputEvent) -> InputEvent:
	if event.is_action_pressed('move_down'):
		emit_signal('finished', 'Duck')
	return .handle_input(host, event)


#warning-ignore:unused_argument
func update(host: Player, delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	if input_direction.x:
		if Input.is_action_pressed('run'):
			emit_signal('finished', 'Run')
		else:
			emit_signal('finished', 'Walk')

	if not host.is_grounded:
		emit_signal('finished', 'Fall')


# Connect to timouet signal through interface
func _on_LookAroundTimer_timeout() -> void:
	animationPlayer.play('LookAround')


func _on_Animation_finished(anim_name: String, host: Player) -> void:
	if anim_name == 'LookAround':
		host.get_node('AnimationPlayer').play('Idle')
		$LookAroundTimer.wait_time = TIME_LEFT
		$LookAroundTimer.start()



