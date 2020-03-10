tool
extends Draw

var parent = null


func _draw():
	if not ProjectSettings.get_setting("Debug/debug_mode"):
		return
	parent = get_parent().get_parent()
	if parent.has_target:
		draw_line(parent.target_position, parent.global_position, color, 2)

	update()
