# Manage ou virtual keyboard and how his input are managed
extends Control

signal keydown(letter)
signal keyup


func _ready():
	$Maj/AMContainer/A.grab_focus()
	for container in get_children():
		for letterContainer in container.get_children():
			for letter in letterContainer.get_children():
				letter.connect("pressed", self, "_on_Press", [letter.text])
				letter.connect("button_up", self, "_on_Button_up")


# When a new letter is press
# @emit keydown(letter)
func _on_Press(letter: String) -> void:
	emit_signal("keydown", letter)


# When a new letter is press
# @emit keyup
func _on_Button_up() -> void:
	emit_signal("keyup")
