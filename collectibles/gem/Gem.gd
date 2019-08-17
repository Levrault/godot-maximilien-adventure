extends Area2D

export (int) var value = 1

func _ready() -> void:
	self.connect('body_entered', self, '_on_Player_enter')
	$AudioStreamPlayer.connect('finished', self, '_on_Sound_finished')
	$AnimationPlayer.play('Idle')


func _on_Player_enter(body: Player) -> void:
	if body is Player:
		GameManager.set_score(value)
		$AudioStreamPlayer.play()
		visible = false


func _on_Sound_finished() -> void:
	queue_free()