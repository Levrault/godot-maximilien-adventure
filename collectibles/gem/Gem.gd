extends Area2D

export (int) var value = 100

func _ready() -> void:
	$AnimationPlayer.play('Idle')
	self.connect('body_entered', self, '_on_Player_enter')


func _on_Player_enter(body: Player) -> void:
	body.get_node('Score').improve_score(value)
	queue_free()