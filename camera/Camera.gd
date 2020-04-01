# Camera
# Global player camera, use to manage transition, effect etc.
# Use CameraManager singleton to transit signal
extends Camera2D

const ZOOM := Vector2(1, 1)
const POSITION := Vector2(0, 20)
enum { FOCUS_IN, FOCUS_OUT }
var focus_type := FOCUS_IN


func _ready() -> void:
	$Tween.connect("tween_completed", self, "_on_Tween_completed")
	$AnimationPlayer.connect("animation_finished", self, "_on_Animation_finished")
	CameraManager.connect("camera_focus_in", self, "_on_Focus_in")
	CameraManager.connect("camera_focus_out", self, "_on_Focus_out")
	CameraManager.connect("camera_zoom_reset", self, "_on_Zoom_reset")
	CameraManager.connect("camera_zoom_out", self, "_on_Zoom")
	CameraManager.connect("camera_transition", self, "_on_Transition")
	$Shader/Transition.visible = false


# Start a camera transitoin
# @signal camera_transition
# @param {string} type e.g. Curtain
func _on_Transition(type: String) -> void:
	smoothing_enabled = false
	$AnimationPlayer.play(type)


func _on_Zoom(new_zoom: Vector2, new_position: Vector2) -> void:
	$TweenZoom.interpolate_property(
		self, "zoom", zoom, new_zoom, 0.5, Tween.EASE_OUT, Tween.EASE_OUT
	)
	$TweenZoom.interpolate_property(
		self, "position", position, new_position, 0.5, Tween.EASE_OUT, Tween.EASE_OUT
	)
	$TweenZoom.start()


func _on_Zoom_reset() -> void:
	$TweenZoom.interpolate_property(self, "zoom", zoom, ZOOM, 0.5, Tween.EASE_IN, Tween.EASE_OUT)
	$TweenZoom.interpolate_property(
		self, "position", position, POSITION, 0.5, Tween.EASE_IN, Tween.EASE_IN
	)
	$TweenZoom.start()


# Focus and focus on a position
# @signal camera_focus_in
# @param {vector2} position_tofocus_
func _on_Focus_in(position_to_focus: Vector2) -> void:
	# comptute offset distance and distance
	focus_type = FOCUS_IN
	var distance = get_parent().position.distance_to(position_to_focus)
	var direction: int = (position_to_focus - get_parent().position).normalized().x
	$Tween.interpolate_property(
		self,
		"offset",
		offset,
		Vector2(distance * direction, -25),
		0.25,
		Tween.TRANS_LINEAR,
		Tween.TRANS_LINEAR
	)
	$Tween.start()


# Reset zoom position
# @signal camera_focus_out
func _on_Focus_out() -> void:
	focus_type = FOCUS_OUT
	$AnimationPlayer.play_backwards("Focus")
	$Tween.interpolate_property(
		self, "offset", offset, Vector2.ZERO, 0.25, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
	)
	$Tween.start()


# Tween callback
# @signal tween_completed
func _on_Tween_completed(object: Object, key: NodePath) -> void:
	if key == ":offset":
		if focus_type == FOCUS_IN:
			_on_Zoom(Vector2(.95, .95), POSITION)
		elif focus_type == FOCUS_OUT:
			_on_Zoom(CameraManager.previous_zoom, POSITION)


# On animation finished
# @signal animation_finished
func _on_Animation_finished(anim_name: String) -> void:
	if anim_name == "Curtain":
		$AnimationPlayer.play("Setup")
		CameraManager.transition_finished()
