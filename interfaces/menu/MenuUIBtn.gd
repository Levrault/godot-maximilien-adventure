# UI button that fade in/out when selected
extends TextureButton
class_name MenuUIBtn

var tween_values := []
var default_rect_position := rect_position


func _ready():
	if not has_user_signal("focus_entered"):
		connect("focus_entered", self, "_on_Focus")
		connect("focus_entered", $AudioStreamPlayer, "play")
	if not has_user_signal("focus_exited"):
		connect("focus_exited", self, "_on_Unfocus")
	$TweenTransform.connect("tween_completed", self, "_on_Tween_completed")

	modulate = Color(1, 1, 1, .2)


# Set or reset default tween_values
func _set_tween_values() -> void:
	tween_values = []
	tween_values.append(Vector2(default_rect_position.x, default_rect_position.y))
	tween_values.append(Vector2(default_rect_position.x + 10, default_rect_position.y))


# @signal focus_entered
func _on_Focus() -> void:
	default_rect_position = rect_position
	_set_tween_values()
	$Tween.interpolate_property(
		self, "modulate", modulate, Color(1, 1, 1, 1), 0.4, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN
	)
	$Tween.start()
	_juicy()


# Juicy effect
func _juicy() -> void:
	$TweenTransform.interpolate_property(
		self, "rect_position", tween_values[0], tween_values[1], 0.4, Tween.EASE_IN, Tween.EASE_OUT
	)
	$TweenTransform.start()


# @signal focus_exited
func _on_Unfocus() -> void:
	$TweenTransform.stop(self)
	_set_tween_values()
	$Tween.interpolate_property(
		self,
		"rect_position",
		rect_position,
		default_rect_position,
		0.4,
		Tween.EASE_IN,
		Tween.EASE_OUT
	)
	$Tween.interpolate_property(
		self, "modulate", modulate, Color(1, 1, 1, .2), 0.4, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN
	)
	$Tween.start()


# Loop through juicy effect
func _on_Tween_completed(object, key):
	tween_values.invert()
	_juicy()
