extends IAMotion

export (float) var PATROL_SPEED:= 80.0
export (float) var PATROL_ACCELERATION:= 0.1


func enter(host: Character) -> void:
	host.speed = PATROL_SPEED
	host.acceleration = PATROL_ACCELERATION


#warning-ignore:unused_argument
func update(host: Character, delta: float) -> void:
	if not host.has_target or host.has_hit_player:
		emit_signal('finished', 'Retreat')
	follow(host, host.target_position)