# Loading screen manager
tool
extends Control

var resource: Resource
var load_completed := false


func _ready() -> void:
	$AnimationPlayerPlane.play("Fly")
	$AnimationPlayer.play("FadeIn")
	load_completed = false


# Update progress bar
# @param {float} progress
func set_progress(progress: float) -> void:
	var progress_bar := $VBoxContainer/ProgressBar
	$Tween.interpolate_property(
		progress_bar, "value", progress_bar.value, progress, .1, Tween.TRANS_LINEAR, Tween.EASE_IN
	)
	$Tween.start()


# @param {Resource} loaded_resource
func set_resource(loaded_resource: Resource) -> void:
	resource = loaded_resource
	$AnimationPlayer.queue("FadeOut")


# Load scene
func go_to_scene() -> void:
	SceneManager.set_new_scene(resource)
