extends Node

signal in_cart
signal move_cart(velocity)


func in_cart() -> void:
	emit_signal('in_cart')


func move(velocity: Vector2) -> void:
	emit_signal('move_cart', velocity)