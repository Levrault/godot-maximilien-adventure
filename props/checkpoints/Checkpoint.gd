extends Node2D
class_name Checkpoint


func _ready():	
	$AnimationPlayer.connect('animation_finished', self, '_on_Animation_finished')
	$AnimationPlayer.play('Inactive')
	$Area2D.connect('body_entered', self, '_on_Player_enter')


#warning-ignore:unused_argument
func _on_Player_enter(body: Player) -> void:
	$AnimationPlayer.play('Transition')
	GameManager.set_new_checkpoint(position)


func _on_Animation_finished(anim_name: String) -> void:
	if anim_name == 'Transition':
		$AnimationPlayer.play('Activated')