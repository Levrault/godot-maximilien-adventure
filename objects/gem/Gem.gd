# Common collectables by the player. Increase score at every pickup
extends Area2D

export (int) var value := 1


func _ready() -> void:
	connect("body_entered", self, "_on_Player_enter")
	$AnimationPlayer.play("Idle")


# @signal body_entered
func _on_Player_enter(body: Player) -> void:
	assert(body is Player)
	GameManager.score = value
	$AnimationPlayer.play("Collected")
	$AudioStreamPlayer.play()
	disconnect("body_entered", self, "_on_Player_enter")
	get_parent().call_deferred("remove_child", self)
	body.call_deferred("add_child", self)
