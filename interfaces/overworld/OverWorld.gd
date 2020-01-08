"""
Overwold allow player to select his new level
"""
extends CanvasLayer

const JSON_READER: Script = preload("res://utils/JSONReader.gd")
const JSON_PATH := "res://config.json"
var window_width = 0

var listen_input := true
var levels := []
var selected_level := 0
var OVERWORLD_PREVIEW_SCENE = load("res://interfaces/overworld/OverWorldLevelPreview.tscn")


func _ready() -> void:
	$Tween.connect("tween_all_completed", self, "_on_Tween_all_completed")
	$Tween.connect("tween_started", self, "_on_Tween_started")
	$Sprite/AnimationPlayer.play("Idle")
	
	if not Engine.editor_hint:
		remove_child($OverWorldLevelPreview)
	window_width = ProjectSettings.get_setting("display/window/size/width")
	_init_preview()


"""
Read config.json file and created all overworld preview
"""
func _init_preview() -> void:
	var i := 0
	for level in JSON_READER.get_json(JSON_PATH, "overworld"):
		var preview: OverWorldLevelPreview = OVERWORLD_PREVIEW_SCENE.instance()
		preview.set_title(TranslationServer.translate(level.title))
		preview.set_preview(load(level.preview_texture_path))
		preview.set_orb(load(level.orb_texture_path))
		preview.set_position(Vector2(i * window_width, 0))
		preview.scene_path = level.scene_path
		i += 1
		levels.append(preview)
		add_child(preview)
	
	levels[0].display_dot(false, true)
	levels[levels.size() - 1].display_dot(true, false)

"""
Move carousel or load level
@param {InputEvent} event
"""
func _input(event: InputEvent) -> void:
	if not listen_input:
		return
	if event.is_action_pressed("move_right") and selected_level < levels.size():
		$Sprite.scale.x = 1
		_next_level()
	if event.is_action_pressed("move_left") and selected_level > 0:
		$Sprite.scale.x = -1
		_prev_level()
	if event.is_action_pressed("enter") or event.is_action_pressed("jump")  or event.is_action_pressed("action"):
		LevelManager.goto_scene(levels[selected_level].scene_path)


"""
Switch to next level
"""
func _next_level() -> void:
	if selected_level == levels.size() - 1:
		selected_level = levels.size() - 1
		return
	selected_level += 1
	_carousel(-window_width)


"""
Switch to prev level
"""
func _prev_level() -> void:
	if selected_level < 0:
		selected_level = 0
		return
	selected_level -= 1
	_carousel(window_width)


"""
Rotate level to show the next one
@param {float} x - offset
"""
func _carousel(x: float) -> void:
	for level in levels:
		var new_position := Vector2(level.get_position().x + x, 0)
		$Tween.interpolate_property(level, "rect_position", level.get_position(), new_position, 0.8, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	$Tween.start()


"""
@signal _on_Tween_started
@param {Objec} object
@param {NodePath} key
"""
func _on_Tween_started(object: Object, key: NodePath) -> void:
	listen_input = false
	$Sprite/AnimationPlayer.play("Walk")


"""
@signal _on_Tween_all_completed
"""
func _on_Tween_all_completed() -> void:
	listen_input = true
	$Sprite/AnimationPlayer.play("Idle")