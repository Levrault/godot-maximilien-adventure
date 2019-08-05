extends Area2D

export (int) var value = 1

func _ready() -> void:
	$AnimationPlayer.play('Idle')
	self.connect('body_entered', self, '_on_Player_enter')


func _on_Player_enter(body: Player) -> void:
	if body is Player:
		GameManager.set_score(value)
		queue_free()