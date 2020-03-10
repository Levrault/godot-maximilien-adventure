extends Motion

export (float) var PATROL_SPEED := 80.0
export (float) var PATRO_ACCELERATION := 0.25

var direction: int = 1


func enter(host: Enemy) -> void:
	host.get_node("AnimationPlayer").play("Patrol")
	host.speed = PATROL_SPEED
	host.acceleration = PATRO_ACCELERATION


#warning-ignore:unused_argument
func update(host: Enemy, delta: float) -> void:
	if not $RayCastFloor.is_colliding() or $RayCastWall.is_colliding():
		direction *= -1
	var direction_vector := Vector2(direction, 0)
	update_look_direction(host, direction_vector)
	move(host, direction_vector, PATROL_SPEED, PATRO_ACCELERATION)
