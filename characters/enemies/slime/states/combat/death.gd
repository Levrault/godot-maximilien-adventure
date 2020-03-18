extends State

export (Resource) var stream = null


func enter(host: Slime) -> void:
	host.get_node("AnimationPlayer").play("Death")
	play_sound(host, stream, rng.randf_range(0.95, 1.15))
	host.velocity = Vector2.ZERO


func _on_Animation_finished(anim_name: String, host):
	GameManager.boss_is_death()
