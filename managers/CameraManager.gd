extends Node

signal camera_zoom_in(position)
signal camera_zoom_out
signal camera_transition(type)
signal camera_transition_entered
signal camera_transition_finished

var player_camera: Camera2D = null setget set_camera, get_camera
var previous_camera_limit_left: int = 0
var previous_camera_limit_right: int = 0
var previous_camera_limit_top: int = 0
var previous_camera_limit_bottom: int = 0


func transition_start(type: String) -> void:
	emit_signal('camera_transition', type)
	emit_signal('camera_transition_entered')


func transition_finished() -> void:
	emit_signal('camera_transition_finished')


func zoom_in(position: Vector2) -> void:
	emit_signal('camera_zoom_in', position)


func zoom_out() -> void:
	emit_signal('camera_zoom_out')


func set_camera(camera: Camera2D) -> void:
	player_camera = camera
	previous_camera_limit_left = player_camera.limit_left
	previous_camera_limit_right = player_camera.limit_right
	previous_camera_limit_top = player_camera.limit_top
	previous_camera_limit_bottom = player_camera.limit_bottom 


func get_camera() -> Camera2D:
	return player_camera


func reset_camera_limit() -> void:
	player_camera.limit_left = previous_camera_limit_left
	player_camera.limit_right = previous_camera_limit_right
	player_camera.limit_top = previous_camera_limit_top
	player_camera.limit_bottom = previous_camera_limit_bottom


func set_camera_limit(limit_min: Vector2, limit_max: Vector2) -> void:
	player_camera.limit_left = int(limit_min.x)
	player_camera.limit_right = int(limit_max.x)
	player_camera.limit_top = int(limit_max.y)
	player_camera.limit_bottom = int(limit_min.y)