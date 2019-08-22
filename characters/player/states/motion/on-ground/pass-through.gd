extends InAir


func enter(host: Player) -> void:
	host.get_node('AnimationPlayer').play('Fall')
	host.set_collision_mask_bit(3, false) # one way platform


func exit(host: Player) -> void:
	host.set_collision_mask_bit(3, true) # one way platform	


#warning-ignore:unused_argument
func update(host: Player, delta: float) -> void:
	if not host.is_on_one_way_platform:
		emit_signal('finished', 'Fall')