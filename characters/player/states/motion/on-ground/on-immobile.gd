extends OnGround
class_name OnImmobile


func enter(host: Player) -> void:
	host.snap_enable = true
	host.velocity.x = 0


func exit(host: Player) -> void:
	host.snap_enable = false
