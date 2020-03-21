extends Node2D


func _ready():
	$CryTrigger.connect("body_entered", self, "_on_Cry_trigger")


# @signal body_entered
func _on_Cry_trigger(body: Player) -> void:
	$AudioStreamPlayer.play()
	$CryTrigger.queue_free()
