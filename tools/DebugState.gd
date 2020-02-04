extends Label


#warning-ignore:unused_argument
func _process(delta):
	if text != DebugManager.get_player_state():
		text = DebugManager.get_player_state()
