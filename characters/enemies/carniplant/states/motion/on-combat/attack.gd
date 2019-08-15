extends Motion 


func enter(host: Enemy) -> void:
	host.get_node('AnimationPlayer').play('Attack')


#warning-ignore:unused_argument
func exit(host: Enemy) -> void:
	$HitDamageZone.set_monitoring(false)
	$CrouchDamageZone.set_monitoring(false)
 

func _on_Animation_finished(anim_name: String, host: Enemy) -> void:
	assert anim_name == 'Attack'
	host.get_node('CooldownTimer').start()
	host.can_attack = false
	emit_signal('finished', 'Idle')
