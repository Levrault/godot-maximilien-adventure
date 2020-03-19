extends TextureButton


func _ready():
	connect("pressed", self, "_on_Pressed")


# @signal pressed
func _on_Pressed() -> void:
	print("quit")
