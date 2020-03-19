extends Motion


func enter(host: Eagle) -> void:
	host.get_node("AnimationPlayer").play("Patrol")
