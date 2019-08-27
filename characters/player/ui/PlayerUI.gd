extends CanvasLayer


func _ready():
	DialogueManager.connect('start_dialogue', self, '_on_Dialogue_start')
	DialogueManager.connect('end_dialogue', self, '_on_Dialogue_end')


func _on_Dialogue_start() -> void:
	for child in get_children():
		child.visible = false


func _on_Dialogue_end() -> void:
	for child in get_children():
		child.visible = true
