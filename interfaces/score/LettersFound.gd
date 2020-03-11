# Manage letter found transition animation.
extends HBoxContainer


# Call through the animation player
# @param {String} letter
func show_letters(letter: String) -> void:
	modulate_letter(get_node(letter), GameManager.letters[letter])


# Start tween to modulate color of label's letter
# @param {Label} label
# @param {bool} found
func modulate_letter(label: Label, found: bool) -> void:
	if found:
		$Tween.interpolate_property(
			label,
			"modulate",
			label.modulate,
			Color(1, 1, 1, 1),
			.5,
			Tween.TRANS_LINEAR,
			Tween.TRANS_LINEAR
		)
		$AudioStreamPlayer.play()
	else:
		$Tween.interpolate_property(
			label,
			"modulate",
			label.modulate,
			Color(1, 1, 1, .15),
			.5,
			Tween.TRANS_LINEAR,
			Tween.TRANS_LINEAR
		)
	$Tween.start()
