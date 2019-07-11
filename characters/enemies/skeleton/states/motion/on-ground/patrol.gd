extends Motion

export (float) var SPEED:= 80.0
export (float) var ACCELERATION:= 0.25

var direction: int = 1

func enter(host: Character) -> void:
	host.get_node('AnimationPlayer').play('Patrol')
#	$WallDetectorArea2D.connect('body_entered', self, '_on_Change_direction')
	host.speed = SPEED
	host.acceleration = ACCELERATION


#warning-ignore:unused_argument
func update(host: Character, delta: float) -> void:
	if not $RayCastFloor.is_colliding() or $RayCastWall.is_colliding():
		direction *= -1
	var direction_vector := Vector2(direction, 0)
	update_look_direction(host, direction_vector)
	move(host, direction_vector, SPEED, ACCELERATION)


#func _on_Change_direction(body: Object) -> void:
#	print(body)
#	direction = direction * -1