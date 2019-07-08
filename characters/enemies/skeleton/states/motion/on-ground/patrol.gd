extends OnGround


func enter(host) -> void:
	host.get_node('AnimationPlayer').play('Patrol')
	host.snap_enable = true
	host.velocity.x = 0


func exit(host) -> void:
	host.snap_enable = false