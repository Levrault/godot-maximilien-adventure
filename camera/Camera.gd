# Camera

# # Global player camera, use to manage transition, effect etc.

# # Use CameraManager singleton to transit signal
extends Camera2D

enum { ZOOM_IN, ZOOM_OUT }
var zoom_type := ZOOM_IN


func _ready() -> void:
	$Tween.connect("tween_completed", self, "_on_Tween_completed")
	$AnimationPlayer.connect("animation_finished", self, "_on_Animation_finished")
	CameraManager.connect("camera_zoom_in", self, "_on_Zoom_in")
	CameraManager.connect("camera_zoom_out", self, "_on_Zoom_out")
	CameraManager.connect("camera_transition", self, "_on_Transition")
	$Shader/Transition.visible = false


# Start a camera transitoin

# # @signal camera_transition


# # @param {string} type e.g. Curtain
func _on_Transition(type: String) -> void:
	smoothing_enabled = false
	$AnimationPlayer.play(type)


# Zoom and focus on a position

# # @signal camera_zoom_in


# # @param {vector2} position_to_zoom
func _on_Zoom_in(position_to_zoom: Vector2) -> void:
	# comptute offset distance and distance
	zoom_type = ZOOM_IN
	var distance = get_parent().position.distance_to(position_to_zoom)
	var direction: int = (position_to_zoom - get_parent().position).normalized().x
	$Tween.interpolate_property(
		self,
		"offset",
		offset,
		Vector2(distance * direction, -50),
		0.25,
		Tween.TRANS_LINEAR,
		Tween.TRANS_LINEAR
	)
	$Tween.start()


# Reset zoom position


# # @signal camera_zoom_out
func _on_Zoom_out() -> void:
	zoom_type = ZOOM_OUT
	$AnimationPlayer.play_backwards("Zoom")
	$Tween.interpolate_property(
		self, "offset", offset, Vector2.ZERO, 0.25, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
	)
	$Tween.start()


# Tween callback


# # @signal tween_completed
func _on_Tween_completed(object: Object, key: NodePath) -> void:
	if key == ":offset":
		if zoom_type == ZOOM_IN:
			$AnimationPlayer.play("Zoom")


# On animation finished


# # @signal animation_finished
func _on_Animation_finished(anim_name: String) -> void:
	if anim_name == "Curtain":
		$AnimationPlayer.play("Setup")
		CameraManager.transition_finished()
