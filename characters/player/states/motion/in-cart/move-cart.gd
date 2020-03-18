extends Motion


func enter(host: Player) -> void:
	host.can_exit_level = true
	host.input_enable = false
	host.get_node("AnimationPlayer").play("MoveCart")
