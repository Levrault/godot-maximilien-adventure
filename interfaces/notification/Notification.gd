extends Control

 
func _ready() -> void:
	GameManager.connect("all_letters_found", $AnimationPlayer, "play", ["Notif"])

