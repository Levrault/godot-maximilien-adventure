"""
Manage rail display under cart with an automatic texture resize
"""
tool
extends Node2D

export (int) var length := 96
export (String) var next_level := ""

const exist_dist := 50


func _ready():
	$Rails.rect_size = Vector2(length, 32)
	$ExitZone.position.x = (length - exist_dist)
	$ExitZone.next_level = next_level


"""
@param {float} delta
"""
func _process(delta: float):
	if Engine.editor_hint:
		if ($Rails.rect_size.x != length):
			$Rails.rect_size = Vector2(length, 32)
			$ExitZone.position.x = (length - exist_dist)