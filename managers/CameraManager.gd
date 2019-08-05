extends Node

signal camera_zoom_in(position)
signal camera_zoom_out


func zoom_in(position: Vector2) -> void:
	emit_signal('camera_zoom_in', position)


func zoom_out() -> void:
	emit_signal('camera_zoom_out')