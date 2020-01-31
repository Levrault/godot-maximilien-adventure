extends Motion

var velocity: Vector2 = Vector2.ZERO

func enter(host: Player) -> void:
	host.can_exit_level = true
	LevelManager.disable_limit_collision()
	velocity = host.velocity
	host.velocity = Vector2.ZERO
	host.get_node("AnimationPlayer").play("MoveCart")


func update(host: Player, delta: float) -> void:
	host.position += velocity