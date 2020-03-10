# Show/hide cinematic bar
extends Control


func _ready() -> void:
	DialogueManager.connect("start_dialogue", self, "_on_Dialogue_start")
	DialogueManager.connect("end_dialogue", self, "_on_Dialogue_end")
	$AnimationPlayer.play("SETUP")


# @signal start_dialogue
func _on_Dialogue_start() -> void:
	$AnimationPlayer.play("Active")


# @signal end_dialogue
func _on_Dialogue_end() -> void:
	$AnimationPlayer.play("Inactive")
