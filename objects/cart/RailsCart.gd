# Manage rail display under cart with an automatic texture resize
tool
extends Node2D

export (int) var length := 96
export (String) var next_level := ""
export (bool) var has_cart := true

const EXIST_DIST := 50


func _ready():
	$Rails.rect_size = Vector2(length, 32)

	if not has_cart:
		$Cart.queue_free()
		$ExitZone.queue_free()
	else:
		$ExitZone.position.x = (length - EXIST_DIST)
		$ExitZone.next_level = next_level


# @param {float} delta
func _process(delta: float):
	if Engine.editor_hint:
		if $Rails.rect_size.x != length:
			$Rails.rect_size = Vector2(length, 32)
			$ExitZone.position.x = (length - EXIST_DIST)
		if not has_cart:
			$ExitZone.hide()
			$Cart.hide()
