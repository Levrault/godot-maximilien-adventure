extends CanvasLayer


func _ready():
	UiManager.connect("ui_loose_life_show", self, "_on_Hide")
	UiManager.connect("ui_loose_life_hide", self, "_on_Show")
	DialogueManager.connect("start_dialogue", self, "_on_Hide")
	DialogueManager.connect("end_dialogue", self, "_on_Show")


"""
Hide all content

@signal ui_loose_life_show
@signal start_dialogue
"""
func _on_Hide() -> void:
	for child in get_children():
		child.visible = false


"""
Hide all content

@signal ui_loose_life_hide
@signal end_dialogue
"""
func _on_Show() -> void:
	for child in get_children():
		child.visible = true