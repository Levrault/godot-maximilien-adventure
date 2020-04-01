extends Node2D

# physics
export (float) var GRAVITY: float = 900


func compute_gravity(host: Projectile, delta: float) -> void:
	host.velocity.y += GRAVITY * delta
	if host.velocity.y > GRAVITY:
		host.velocity.y = GRAVITY

	#warning-ignore:return_value_discarded
	host.move_and_collide(host.velocity * delta)
