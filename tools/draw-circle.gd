tool
extends Draw


func _draw():
	if not ProjectSettings.get_setting("Debug/debug_mode"):
		return
	if owner.get(value):
		draw_circle_outline(owner.get(value), color)
	update()
