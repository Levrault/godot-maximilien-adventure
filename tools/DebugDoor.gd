tool
extends Control

var previous_portal: String = ""


func _ready():
	if not ProjectSettings.get_setting("Debug/debug_mode"):
		queue_free()

	$Level.text = get_parent().portal


func _process(delta):
	if Engine.editor_hint:
		if previous_portal != get_parent().portal:
			previous_portal = get_parent().portal
			$Level.text = get_parent().portal
