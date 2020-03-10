# Wasp will follow the player and make it paid for behing to close
extends IAMotion

export (float) var PATROL_SPEED := 80.0
export (float) var PATROL_ACCELERATION := 0.1


func enter(host: Wasp) -> void:
	host.speed = PATROL_SPEED
	host.acceleration = PATROL_ACCELERATION


# @emit finished(Retreat)
func update(host: Wasp, delta: float) -> void:
	if not host.has_target or host.has_hit_player:
		emit_signal("finished", "Retreat")
	follow(host, host.target_position)
