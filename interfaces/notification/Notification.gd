extends Control

 
func _ready() -> void:
	GameManager.connect("notif", self, "push")


func push(locale_key: String) -> void:
	$Parchment/PixelLabel.locale_key = locale_key
	$Parchment/PixelLabel.retranslate()
	$AnimationPlayer.play("Notif")
