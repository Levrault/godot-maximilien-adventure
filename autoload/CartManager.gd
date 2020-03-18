# Singleton that manage cart signal (exit level)
extends Node

signal in_cart
signal move_cart


# @emit in_cart
func in_cart() -> void:
	emit_signal("in_cart")


# @emit move_cart(velocity)
func move() -> void:
	emit_signal("move_cart")
