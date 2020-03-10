extends Label

export (String) var props = ""


#warning-ignore:unused_argument
func _process(delta):
	if text != String(DebugManager.get_player().get(props)):
		text = String(DebugManager.get_player().get(props))
