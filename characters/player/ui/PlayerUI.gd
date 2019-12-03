extends CanvasLayer


func _ready():
	UiManager.connect('ui_loose_life_show', self, '_on_Hide')
	DialogueManager.connect('start_dialogue', self, '_on_Hide')
	DialogueManager.connect('end_dialogue', self, '_on_Show')


func _on_Hide() -> void:
	for child in get_children():
		child.visible = false


func _on_Show() -> void:
	for child in get_children():
		child.visible = true