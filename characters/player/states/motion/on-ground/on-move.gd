extends OnGround
class_name OnMove


func enter(host: Character) -> void:
	host.snap_enable = true
	host.speed = SPEED
	host.acceleration = ACCELERATION


func exit(host: Character) -> void:
	host.snap_enable = false


# @emit finished(Idle)
# @emit finished(Fall)
func update(host: Character, delta: float) -> void:
	if host.in_cart:
		emit_signal("finished", "InCart")
	var input_direction: Vector2 = get_input_direction()
	update_look_direction(host, get_input_direction())
	if not input_direction or not input_direction.x:
		emit_signal("finished", "Idle")

	if not host.is_grounded:
		emit_signal("finished", "Fall")

	move(host, input_direction, SPEED, ACCELERATION)
