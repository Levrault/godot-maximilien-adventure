extends TileMap
tool

export (Color) var color = Color(255, 255, 255, 255)

#warning-ignore:unused_argument
func _process(delta):
	if not ProjectSettings.get_setting('Debug/tilemap_layer'):
		return
	if modulate != color:
		modulate = color