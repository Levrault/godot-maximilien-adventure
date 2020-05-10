# Manage checkpoint
extends Node2D
class_name Checkpoint


func _ready():
	$AnimationPlayer.connect("animation_finished", self, "_on_Animation_finished")
	$AnimationPlayer.play("Inactive")
	$Area2D.connect("body_entered", self, "_on_Player_enter")


# Set new player checkpoint
# @param {Player} body
func _on_Player_enter(body: Player) -> void:
	assert(body is Player)
	if $AnimationPlayer.current_animation == "Inactive":
		$AnimationPlayer.play("Transition")
		GameManager.set_new_checkpoint(position)


# @signal animation_finished
# @param {String} anim_name
func _on_Animation_finished(anim_name: String) -> void:
	if anim_name == "Transition":
		$AnimationPlayer.play("Activated")
