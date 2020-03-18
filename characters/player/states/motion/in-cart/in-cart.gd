extends Motion


func enter(host: Player) -> void:
	host.get_node("AnimationPlayer").play("Idle")
	host.input_enable = false
	host.gravity_enable = false
	host.velocity = Vector2.ZERO
	CartManager.connect("move_cart", self, "_move_Cart")


func exit(host: Player) -> void:
	CartManager.disconnect("move_cart", self, "_move_Cart")


func update(host: Character, delta: float) -> void:
	update_look_direction(host, Vector2(1, 0))


# @signal move_cart
# @emit finished(MoveCart)
func _move_Cart() -> void:
	emit_signal("finished", "MoveCart")
