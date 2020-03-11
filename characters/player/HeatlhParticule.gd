extends Particles2D


# Change velocity of process material to make
# it move when the player move
# @signal player_velocity(velocity)
# @param {float} new_velocity_x
func _on_Velocity_change(velocity: Vector2) -> void:
	var gravity: Vector3 = get_process_material().gravity
	get_process_material().gravity = Vector3((velocity.x * -1) / 2, gravity.y, gravity.z)


# Emit particule when healing
func on_Healing() -> void:
	one_shot = true
	emitting = true
