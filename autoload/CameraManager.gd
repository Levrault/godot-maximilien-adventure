# Singleton that manage all camera signal
extends Node

# zoom and move to a position
signal camera_zoom_in(position)
# reset by zooming out
signal camera_zoom_out
# camera transition eg. fade in, out etc.
signal camera_transition(type)
signal camera_transition_entered
signal camera_transition_finished

var player_camera: Camera2D = null setget set_camera, get_camera
var previous_camera_limit_left: int = 0
var previous_camera_limit_right: int = 0
var previous_camera_limit_top: int = 0
var previous_camera_limit_bottom: int = 0


# @emit camera_transition(type)
# @emit camera_transition_entered
# @param {String} type
func transition_start(type: String) -> void:
	emit_signal("camera_transition", type)
	emit_signal("camera_transition_entered")


# @emit camera_transition_finished
func transition_finished() -> void:
	emit_signal("camera_transition_finished")


# @emit camera_zoom_in(position)
# @param {Vector2} position
func zoom_in(position: Vector2) -> void:
	emit_signal("camera_zoom_in", position)


# @emit camera_zoom_out
func zoom_out() -> void:
	emit_signal("camera_zoom_out")


# Set current camara that will be managed by the singleton


# # @param {Camera2D} camera
func set_camera(camera: Camera2D) -> void:
	player_camera = camera
	previous_camera_limit_left = player_camera.limit_left
	previous_camera_limit_right = player_camera.limit_right
	previous_camera_limit_top = player_camera.limit_top
	previous_camera_limit_bottom = player_camera.limit_bottom


# getter for player_camera


# # @return {Camera2D}
func get_camera() -> Camera2D:
	return player_camera


# reset camera limit
func reset_camera_limit() -> void:
	player_camera.limit_left = previous_camera_limit_left
	player_camera.limit_right = previous_camera_limit_right
	player_camera.limit_top = previous_camera_limit_top
	player_camera.limit_bottom = previous_camera_limit_bottom


# set camera limit
# @param {Vector2} limit_min
# @param {Vector2} limit_max
func set_camera_limit(limit_min: Vector2, limit_max: Vector2) -> void:
	player_camera.limit_left = int(limit_min.x)
	player_camera.limit_right = int(limit_max.x)
	player_camera.limit_top = int(limit_max.y)
	player_camera.limit_bottom = int(limit_min.y)
