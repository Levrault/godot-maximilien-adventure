# Physics class for kinematic body 2D
extends Node2D
class_name Physics2D

# physics
export (float) var GRAVITY := 900.0

const FLOOR_NORMAL := Vector2(0, -1)
const SLOPE_SLIDE_STOP := 5.0
const SNAP := Vector2(0, 16)
const MAX_SLOPE_DEGREE := deg2rad(46)


# @param {Character} host
# @param {float} delta
func compute_gravity(host: Character, delta: float) -> void:
	if host.gravity_enable:
		host.velocity.y += GRAVITY * delta
		if host.velocity.y > GRAVITY:
			host.velocity.y = GRAVITY

	if host.snap_enable:
		host.velocity = host.move_and_slide_with_snap(
			host.velocity, SNAP, FLOOR_NORMAL, SLOPE_SLIDE_STOP, 5, MAX_SLOPE_DEGREE
		)
	else:
		host.velocity = host.move_and_slide(
			host.velocity, FLOOR_NORMAL, SLOPE_SLIDE_STOP, 5, MAX_SLOPE_DEGREE
		)

	host.is_grounded = host.is_on_floor()
