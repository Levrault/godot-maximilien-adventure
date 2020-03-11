extends CanvasLayer


func _ready():
	UiManager.connect("ui_player_hide", self, "_on_Hide")
	UiManager.connect("ui_player_show", self, "_on_Show")
	DialogueManager.connect("start_dialogue", self, "_on_Hide")
	DialogueManager.connect("end_dialogue", self, "_on_Show")


# Hide all content
# @signal ui_player_hide
# @signal start_dialogue
func _on_Hide() -> void:
	for child in get_children():
		child.visible = false


# Hide all content
# @signal ui_player_show
# @signal end_dialogue
func _on_Show() -> void:
	for child in get_children():
		child.visible = true
