extends Control


# @param {InputEvent} event
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("screenshot"):
		# get data
		var img = get_viewport().get_texture().get_data()
		# wait two frames
		yield(get_tree(), "idle_frame")
		yield(get_tree(), "idle_frame")

		# flip
		img.flip_y()

		img.resize(480, 270, 0)

		# save to file
		img.save_png("screenshot.png")

		$AnimationPlayer.play("TransitionIn")
