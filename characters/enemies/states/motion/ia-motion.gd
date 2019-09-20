extends Motion
class_name IAMotion


func move_to_point(host: Character, input_direction: Vector2, speed: float, acceleration: float) -> void:
	host.velocity.x = lerp(host.velocity.x, input_direction.x * speed, acceleration)
	host.velocity.y = lerp(host.velocity.y, input_direction.y * speed, acceleration)


func follow(host: Character, target_position: Vector2) -> void:
	var target_direction = (target_position - host.position).normalized() 
	update_look_direction(host, Vector2(int(round(target_direction.x)), 0))
	move_to_point(host, target_direction, SPEED, ACCELERATION)