# Manage feather juicy action
extends Control


# @param {bool} reached - does max number of character has been reached
func _on_Max(reached: bool) -> void:
	if reached:
		$Tween.interpolate_property(
			$FeatherLeft,
			"modulate",
			modulate,
			Color(1, 1, 1, .1),
			0.4,
			Tween.TRANS_LINEAR,
			Tween.EASE_OUT_IN
		)
		$Tween.interpolate_property(
			$FeatherRight,
			"modulate",
			modulate,
			Color(1, 1, 1, .1),
			0.4,
			Tween.TRANS_LINEAR,
			Tween.EASE_OUT_IN
		)
	else:
		$Tween.interpolate_property(
			$FeatherLeft,
			"modulate",
			Color(1, 1, 1, .1),
			Color(1, 1, 1, 1),
			0.4,
			Tween.TRANS_LINEAR,
			Tween.EASE_OUT_IN
		)
		$Tween.interpolate_property(
			$FeatherRight,
			"modulate",
			Color(1, 1, 1, .1),
			Color(1, 1, 1, 1),
			0.4,
			Tween.TRANS_LINEAR,
			Tween.EASE_OUT_IN
		)
	$Tween.start()
