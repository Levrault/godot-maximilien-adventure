extends Label

var previous_velocity: Vector2 = Vector2.ZERO


#warning-ignore:unused_argument
func _process(delta):
	var current_velocity := DebugManager.get_player_velocity()
	if previous_velocity != current_velocity:
		previous_velocity = current_velocity
		text = "(%s, %s)" % [stepify(current_velocity.x, .01), stepify(current_velocity.y, .01)]
