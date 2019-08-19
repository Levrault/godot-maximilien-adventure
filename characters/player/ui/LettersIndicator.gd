extends Control

func _ready() -> void:
	GameManager.connect('letter_found', self, '_on_Letter_changed')


func _on_Letter_changed(letter_found: String) -> void:
	print('letter_found: %s' % [letter_found])
	for letter in $HBoxContainer.get_children():
		if letter.text == letter_found:
			letter.modulate = Color(1, 1, 1, 1)
