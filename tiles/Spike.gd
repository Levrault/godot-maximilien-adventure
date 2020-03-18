# Spike are use in tilemap spike and damage playe
extends Sprite

const AMOUNT := 100.0


func _ready():
	$Area2D.connect("body_entered", self, "_on_Body_entered")


func _on_Body_entered(body: Player) -> void:
	body.get_node("Health").take_damage(AMOUNT)
