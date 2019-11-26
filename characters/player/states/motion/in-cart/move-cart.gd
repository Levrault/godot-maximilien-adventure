extends Motion

var velocity: Vector2 = Vector2.ZERO

func enter(host: Player) -> void:
	host.can_exit_level = true
	velocity = host.velocity
	host.velocity = Vector2.ZERO
	host.get_node('AnimationPlayer').play('MoveCart')


# warning-ignore:unused_argument
func update(host: Player, delta: float) -> void:
	host.position += velocity