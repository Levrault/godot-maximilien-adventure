extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_Body_Entered")
	connect("body_exited", self, "_on_Body_Exited")


func _on_Body_Entered(body: Node) -> void:
	body.get_node("AnimationPlayer").play("Reveal")


func _on_Body_Exited(body: Node) -> void:
	body.get_node("AnimationPlayer").play_backwards("Reveal")
