# Simple computing to move a static element
extends Node2D
class_name Movable


# @param {StaticBody2D} host
# @param {float} delta
func compute_movement(host: StaticBody2D, delta: float) -> void:
	if host.can_move:
		host.position += host.velocity
