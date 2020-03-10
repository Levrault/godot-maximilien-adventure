# Exclamation point controller
extends Control


func _ready() -> void:
	$AnimationPlayer.play("SETUP")


func show() -> void:
	$AnimationPlayer.play("Show")
