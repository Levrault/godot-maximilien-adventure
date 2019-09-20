extends Motion


func enter(host: Character) -> void:
	host.get_node('AnimationPlayer').play('Idle')


#warning-ignore:unused_argument
func update(host: Character, delta: float) -> void:
	if host.has_target:
		emit_signal('finished', 'Patrol')
	host.velocity = Vector2.ZERO
	