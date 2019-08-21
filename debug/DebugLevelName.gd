extends Label

var previous_level_name: String = 'Placeholder'

#warning-ignore:unused_argument
func _process(delta):
	if previous_level_name != text:
		text = DebugManager.get_level_name()