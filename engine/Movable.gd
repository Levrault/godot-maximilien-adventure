extends Node2D
class_name Movable



# warning-ignore:unused_argument
func compute_movement(host, delta: float) -> void:
	if host.can_move:
		host.position += host.velocity