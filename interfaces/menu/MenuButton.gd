extends TextureButton


func _ready():
	connect("focus_entered", self, "_on_Focus")
	connect("focus_exited", self, "_on_Unfocus")
	modulate = Color(1, 1, 1, .2)


func _on_Focus() -> void:
	$Tween.interpolate_property(
		self, "modulate", modulate, Color(1, 1, 1, 1), 0.4, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN
	)
	$Tween.start()


func _on_Unfocus() -> void:
	$Tween.interpolate_property(
		self, "modulate", modulate, Color(1, 1, 1, .2), 0.4, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN
	)
	$Tween.start()
