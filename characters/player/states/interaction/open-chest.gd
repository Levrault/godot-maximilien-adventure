extends Motion

export (Resource) var stream = null


# Set camera and play sound
# @param {Player} host
func enter(host: Player) -> void:
	host.get_node("AnimationPlayer").play("Idle")

	assert(stream != null)
	play_sound(host, stream, rng.randf_range(0.95, 1.15))

	# set camera zoom
	CameraManager.focus_in(host.chest_position)

	# open the chest
	ChestManager.active_chest()

	# update player direction to look at the npc
	var direction = (host.chest_position - host.position).normalized()
	update_look_direction(host, Vector2(int(round(direction.x)), 0))
	host.snap_enable = true
	host.velocity.x = 0


# @emit camera_zoom_out - though CameraManager
# @param {Player} host
func exit(host: Player) -> void:
	host.snap_enable = false
	CameraManager.focus_out()


# @emit finished(Idle)
func update(host: Player, delta: float):
	if not host.can_open_chest:
		print("Player exited open-chest state")
		emit_signal("finished", "Idle")
