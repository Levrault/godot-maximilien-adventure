"""
Singleton that manage cart signal (exit level)
"""
extends Node

# when player has entered the cart
signal in_cart
# make the cart move
signal move_cart(velocity)


"""
@emit in_cart
"""
func in_cart() -> void:
	emit_signal("in_cart")


"""
@emit move_cart(velocity)

@param {Vector2} velocity
"""
func move(velocity: Vector2) -> void:
	emit_signal("move_cart", velocity)