extends Control


func _ready() -> void:
	GameManager.connect("letter_found", self, "_on_Letter_changed")
	GameManager.connect("all_letters_found", $AnimationPlayer, "play", ["Success"])


# signal letter_found - GameManager
func _on_Letter_changed(letter_found: String) -> void:
	print("letter_found: %s" % [letter_found])
	for letter in get_children():
		if letter is Label and letter.text == letter_found:
			letter.modulate = Color(1, 1, 1, 1)
