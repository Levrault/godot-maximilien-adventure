extends State
class_name Death

func enter(host: Character) -> void:
	if host.get_node('AnimationPlayer').has_animation('Death'):
		host.get_node('AnimationPlayer').play('Death')
	host.snap_enable = true
	host.velocity = Vector2(0, 0)


#warning-ignore:unused_argument
#warning-ignore:unused_argument
func _on_Animation_finished(anim_name: String, host: Character) -> void:
	assert anim_name == 'Death'
	$Explosion.start()