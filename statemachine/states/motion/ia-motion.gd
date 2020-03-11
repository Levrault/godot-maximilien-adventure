# Motion function use by an IA
extends Motion
class_name IAMotion


# Change the velocity the move the character at a specefic point
# @param {Character} host
# @param {Vector2} direction
# @param {float} speed
# @param {float} acceleration
func move_to_point(host: Character, direction: Vector2, speed: float, acceleration: float) -> void:
	host.velocity.x = lerp(host.velocity.x, direction.x * speed, acceleration)
	host.velocity.y = lerp(host.velocity.y, direction.y * speed, acceleration)


# Make the character follow a thing (based on his position)
# @param {Character} host
# @param {Vector2} target_position
func follow(host: Character, target_position: Vector2) -> void:
	var target_direction = (target_position - host.position).normalized()
	update_look_direction(host, Vector2(int(round(target_direction.x)), 0))
	move_to_point(host, target_direction, SPEED, ACCELERATION)
