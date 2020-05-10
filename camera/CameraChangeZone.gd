# A simple camera zoom change feature
# Pretty meh since my fall system is based on camera limit 
# and this script needs to change it
extends Area2D
class_name CameraChangeZone

export (Vector2) var zoom := Vector2(2, 2)
export (Vector2) var camera_position := Vector2(0, 20)

export (bool) var active_camera_limit_top := false
export (int) var camera_limit_top := 0
var previous_camera_limit_top = 0

export (bool) var active_camera_limit_right := false
export (int) var camera_limit_right := 0
var previous_camera_limit_right = 0

export (bool) var active_camera_limit_bottom := false
export (int) var camera_limit_bottom := 0
var previous_camera_limit_bottom = 0

export (bool) var active_camera_limit_left := false
export (int) var camera_limit_left := 0
var previous_camera_limit_left = 0


func _init() -> void:
	set_collision_layer_bit(0, false)
	set_collision_mask_bit(0, false)
	set_collision_mask_bit(1, true)


func _ready() -> void:
	connect("body_entered", self, "_on_Player_enter")
	connect("body_exited", self, "_on_Player_exited")

	if active_camera_limit_top:
		previous_camera_limit_top = CameraManager.player_camera.limit_top
	if active_camera_limit_right:
		previous_camera_limit_right = CameraManager.player_camera.limit_right
	if active_camera_limit_bottom:
		previous_camera_limit_bottom = CameraManager.player_camera.limit_bottom
	if active_camera_limit_left:
		previous_camera_limit_left = CameraManager.player_camera.limit_left


# Change camera zoom and limit
# param {Player} body
# @signal body_entered
# @emit zoom_out
func _on_Player_enter(body: Player) -> void:
	print("GameManager.compute_fall_damage has been set to FALSE")
	GameManager.compute_fall_damage = false
	CameraManager.zoom_out(zoom, camera_position)
	if active_camera_limit_top:
		CameraManager.player_camera.limit_top = camera_limit_bottom
	if active_camera_limit_right:
		CameraManager.player_camera.limit_right = camera_limit_right
	if active_camera_limit_bottom:
		CameraManager.player_camera.limit_bottom = camera_limit_bottom
	if active_camera_limit_left:
		CameraManager.player_camera.limit_left = camera_limit_left


# Reset camera zoom and limit
# param {Player} body
# @signal body_exited
# @emit reset_zoom
func _on_Player_exited(body: Player) -> void:
	CameraManager.reset_zoom()
	if active_camera_limit_top:
		CameraManager.player_camera.limit_top = previous_camera_limit_top
	if active_camera_limit_right:
		CameraManager.player_camera.limit_right = previous_camera_limit_right
	if active_camera_limit_bottom:
		print("in")
		CameraManager.player_camera.limit_bottom = previous_camera_limit_bottom
	if active_camera_limit_left:
		CameraManager.player_camera.limit_left = previous_camera_limit_left

	print("GameManager.compute_fall_damage has been set to TRUE")
	GameManager.compute_fall_damage = true
