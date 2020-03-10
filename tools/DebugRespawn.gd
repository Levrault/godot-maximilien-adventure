extends Label

var previous_respawn: Vector2 = Vector2.ZERO


#warning-ignore:unused_argument
func _process(delta):
	var current_respawn := DebugManager.get_player_respawn()
	if previous_respawn != current_respawn:
		previous_respawn = current_respawn
		text = "(%s, %s)" % [stepify(current_respawn.x, .01), stepify(current_respawn.y, .01)]
