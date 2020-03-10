tool
extends Draw

var parent = null


func _draw():
	if not ProjectSettings.get_setting("Debug/debug_mode"):
		return
	if Engine.editor_hint:
		parent = get_parent().get_parent()
		if parent.has_node("House"):
			draw_line(Vector2.ZERO, parent.get_node("House").position, color, 2)
	update()
