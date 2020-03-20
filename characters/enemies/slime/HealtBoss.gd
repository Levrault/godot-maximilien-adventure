extends Health


func _input(event: InputEvent) -> void:
	pass


# Damage the character.
# @param {float} amount - amount of health to remove
# @emit health_changed, take_damage
func take_damage(amount: float) -> void:
	.take_damage(amount)
	$Momentum.momentum()
