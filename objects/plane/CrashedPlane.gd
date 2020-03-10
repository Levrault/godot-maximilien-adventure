# Animation manager for plane
extends Node2D


func _ready() -> void:
	$AnimationPlayer.play("Crash")
