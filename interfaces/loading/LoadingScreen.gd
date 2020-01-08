"""
Loading screen manager
"""
tool
extends Control

var resource: Resource
var load_completed := false


func _ready() -> void:
	$Tween.connect("tween_completed", self, "_on_tween_completed")
	load_completed = false


"""
Update progress bar

@param {float} progress
"""
func set_progress(progress: float) -> void:
	var progress_bar := find_node("ProgressBar")
	$Tween.interpolate_property(progress_bar, "value", progress_bar.value, progress, .5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()


"""
Hide when loading is over and enter is press

@param {InputEvent} event
"""
func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("enter") or event.is_action_pressed("action")) and load_completed:
		LevelManager.set_new_scene(resource)
		queue_free()


"""
@param {Resource} loaded_resource
"""
func set_resource(loaded_resource: Resource) -> void:
	resource = loaded_resource
	load_completed = true


"""
@signal tween_completed

@param {Object} object
@param {NodePath} key
"""
func _on_tween_completed(object: Object, key: NodePath) -> void:
	match object.get_name():
		"ProgressBar":
			if object.value == 100:
				$AnimationPlayer.play("Blink")