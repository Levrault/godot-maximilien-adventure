# Singleton that manage cart signal (exit level)
extends Node

signal in_cart
signal move_cart(velocity)


# @emit in_cart
func in_cart() -> void:
	emit_signal("in_cart")


# @emit move_cart(velocity)
# @param {Vector2} velocity
func move(velocity: Vector2) -> void:
	emit_signal("move_cart", velocity)
