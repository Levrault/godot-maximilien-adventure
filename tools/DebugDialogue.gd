extends Label


#warning-ignore:unused_argument
func _process(delta):
	if text != String(DebugManager.get_player().can_talk):
		text = String(DebugManager.get_player().can_talk)
