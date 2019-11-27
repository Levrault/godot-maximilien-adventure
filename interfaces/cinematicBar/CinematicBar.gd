extends Control


func _ready() -> void:
	DialogueManager.connect('start_dialogue', self, '_on_Dialogue_start')
	DialogueManager.connect('end_dialogue', self, '_on_Dialogue_end')
	$AnimationPlayer.play('Setup')


func _on_Dialogue_start() -> void:
	$AnimationPlayer.play('Active')


func _on_Dialogue_end() -> void:
	$AnimationPlayer.play('Inactive')