tool
extends TileMap

export (Color) var color = Color(255, 255, 255, 255)


#warning-ignore:unused_argument
func _process(delta):
	if not ProjectSettings.get_setting("Debug/tilemap_layer"):
		modulate = Color(1, 1, 1, 1)
		return
	if modulate != color:
		modulate = color
