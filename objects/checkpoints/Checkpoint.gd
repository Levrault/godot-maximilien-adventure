# Manage checkpoint
extends Node2D
class_name Checkpoint


func _ready():
	$AnimationPlayer.play("Inactive")
	$Area2D.connect("body_entered", self, "_on_Player_enter")


# Set new player checkpoint
# @param {Player} body
func _on_Player_enter(body: Player) -> void:
	assert(body is Player)
	$Area2D.disconnect("body_entered", self, "_on_Player_enter")
	$AnimationPlayer.play("Transition")
	GameManager.set_new_checkpoint(position)