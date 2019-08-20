extends Node2D
class_name Checkpoint


func _ready():
	$AnimationPlayer.connect('animation_finished', self, '_on_Animation_finished')
	$AnimationPlayer.play('Inactive')
	$Area2D.connect('body_entered', self, '_on_Player_enter')

	if not ProjectSettings.get_setting('Debug/sound'):
		$AudioStreamPlayer.stream = null


func _on_Player_enter(body: Player) -> void:
	assert body is Player
	if $AnimationPlayer.current_animation == 'Inactive':
		$AnimationPlayer.play('Transition')
		GameManager.set_new_checkpoint(position)


func _on_Animation_finished(anim_name: String) -> void:
	if anim_name == 'Transition':
		$AnimationPlayer.play('Activated')