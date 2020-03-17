# Overwold allow player to select his new level
extends CanvasLayer

var window_width = 0
var listen_input := true
var levels := []
var selected_level := 0
var last_unlocked_level := 0
var OVERWORLD_PREVIEW_SCENE = load("res://interfaces/overworld/OverWorldLevelPreview.tscn")


func _ready() -> void:
	$Tween.connect("tween_all_completed", self, "_on_Tween_all_completed")
	$Tween.connect("tween_started", self, "_on_Tween_started")
	$Sprite/AnimationPlayer.play("Idle")

	MusicManager.change_music("overworld")

	if ProjectSettings.get_setting("Debug/force_save"):
		if ProgressionManager.path == "":
			ProgressionManager.path = "profile0"
			ProgressionManager.load_game()

	if not Engine.editor_hint:
		remove_child($OverWorldLevelPreview)
	window_width = ProjectSettings.get_setting("display/window/size/width")
	_init_preview()


# Read config.json file and created all overworld preview
func _init_preview() -> void:
	# place player in env
	selected_level = ProgressionManager.save_data.current_level - 1
	last_unlocked_level = selected_level
	for level in ProgressionManager.config_data:
		var preview: OverWorldLevelPreview = OVERWORLD_PREVIEW_SCENE.instance()
		preview.set_title(TranslationServer.translate(level.title))
		preview.set_preview(load(level.preview_texture_path))
		preview.set_orb(load(level.orb_texture_path))
		preview.scene_path = level.scene_path
		preview.level = level.key
		preview.max_score = level.max_score
		# merge with saved data
		if ProgressionManager.save_data.levels.has(level.key):
			var saved_level_data = ProgressionManager.save_data.levels[level.key]
			preview.score = saved_level_data.gems_collected
			preview.letters.M = saved_level_data.m_letter_found
			preview.letters.A = saved_level_data.a_letter_found
			preview.letters.X = saved_level_data.x_letter_found
			levels.append(preview)
			add_child_below_node($Sprite, preview)
		else:
			preview.queue_free()

	# manage dot display
	levels[0].display_dot(false, true)
	levels[last_unlocked_level].display_dot(true, false)

	# select the next uncompleted level
	_init_player_progression_in_carousel()
	_update_collectibles()


# Move carousel or load level
# @param {InputEvent} event
func _input(event: InputEvent) -> void:
	if not listen_input:
		return

	if event.is_action_pressed("move_up"):
		$PrevButton.focus_mode = 2
		$PrevButton.grab_focus()
	if event.is_action_pressed("move_down"):
		$PrevButton.focus_mode = 0
	if event.is_action_pressed("move_right") and selected_level < last_unlocked_level:
		$PrevButton.focus_mode = 0
		$Sprite.scale.x = 1
		_next_level()
		_update_collectibles()
	if event.is_action_pressed("move_left") and selected_level > 0:
		$PrevButton.focus_mode = 0
		$Sprite.scale.x = -1
		_prev_level()
		_update_collectibles()
	if (
		event.is_action_pressed("enter")
		or event.is_action_pressed("jump")
		or event.is_action_pressed("action")
	):
		if not $PrevButton.has_focus():
			GameManager.level = levels[selected_level].level
			SceneManager.goto_scene(levels[selected_level].scene_path)


# Switch to next level
func _next_level() -> void:
	if selected_level == last_unlocked_level:
		selected_level = last_unlocked_level
		return
	selected_level += 1
	_carousel(-window_width)


# Switch to prev level
func _prev_level() -> void:
	if selected_level < 0:
		selected_level = 0
		return
	selected_level -= 1
	_carousel(window_width)


# Set carousel index depending on player position
func _init_player_progression_in_carousel() -> void:
	var i := last_unlocked_level
	for level in levels:
		var new_position := Vector2(level.get_position().x - (window_width * i), 0)
		level.rect_position = new_position
		i -= 1


# Rotate level to show the next one
# @param {float} x - offset
func _carousel(x: float) -> void:
	for level in levels:
		var new_position := Vector2(level.get_position().x + x, 0)
		$Tween.interpolate_property(
			level,
			"rect_position",
			level.get_position(),
			new_position,
			0.8,
			Tween.TRANS_LINEAR,
			Tween.EASE_OUT_IN
		)
	$Tween.start()
	$AudioStreamPlayer.play()


# Update letters and gems date of selected level
func _update_collectibles() -> void:
	$Informations/Gems/Score.text = String(levels[selected_level].score)
	$Informations/Gems/Max.text = String(levels[selected_level].max_score)
	for letter in levels[selected_level].letters:
		if levels[selected_level].letters[letter]:
			$Informations/LettersFound.get_node(letter).modulate = Color(1, 1, 1, 1)
		else:
			$Informations/LettersFound.get_node(letter).modulate = Color(1, 1, 1, .4)


# @signal _on_Tween_started
# @param {Objec} object
# @param {NodePath} key
func _on_Tween_started(object: Object, key: NodePath) -> void:
	listen_input = false
	$Sprite/AnimationPlayer.play("Walk")


# @signal _on_Tween_all_completed
func _on_Tween_all_completed() -> void:
	listen_input = true
	$Sprite/AnimationPlayer.play("Idle")
