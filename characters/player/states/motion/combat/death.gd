extends State

export (Resource) var stream = null


# @param {Player} host
func enter(host: Player) -> void:
	host.get_node("AnimationPlayer").play("Death")
	host.is_invincible = true
	host.set_collision_layer_bit(1, false)

	assert(stream != null)
	play_sound(host, stream, 1)

	host.input_enable = false
	host.velocity = Vector2.ZERO
	host.gravity_enable = false


# @emit ui_loose_life_show
# @emit ui_game_over_show
func show_ui() -> void:
	if GameManager.player_life == 1:
		UiManager.show_game_over()
	else:
		UiManager.show_lost_a_life_screen()


# @signal animation_finished
func _on_Animation_finished(anim_name: String, host: Player) -> void:
	assert(anim_name == "Death")
	assert(host is Player)
	emit_signal("finished", "Respawn")
