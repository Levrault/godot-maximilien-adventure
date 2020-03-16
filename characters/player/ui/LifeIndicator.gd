tool
extends HBoxContainer

export (String, "small", "medium", "large") var icon_size_flag := "small"
var Icon = preload("res://characters/player/ui/PlayerIcon.tscn")

# debug
var previous_icon_size := "small"


func _ready() -> void:
	GameManager.connect("player_life", self, "_on_Player_life_change")
	if not Engine.editor_hint:
		_on_Player_life_change(GameManager.player_life)


# Swith icon size in debug mod
func _process(delta: float) -> void:
	if Engine.editor_hint:
		if previous_icon_size != icon_size_flag:
			previous_icon_size = icon_size_flag
			_on_Player_life_change(3)


# Update number of life displayed
# @signal player_life
# @param {int} life
func _on_Player_life_change(life: int) -> void:
	# clear previous icon
	for icon in get_children():
		icon.queue_free()

	# new values
	var i := 1
	var new_icon_size_flag = get_icon_size_flag()
	while i <= life:
		var icon = Icon.instance()
		icon.rect_size = new_icon_size_flag
		icon.rect_min_size = new_icon_size_flag
		add_child(icon)
		i += 1

	# compute vbox rect_size with all icon and separation
	compute_rect_size(life)


# Refize flag depending on the number of life
# @param {int} life
func compute_rect_size(life: int) -> void:
	var new_icon_size_flag = get_icon_size_flag()
	var x_container_rect_size = (
		(new_icon_size_flag.x * life)
		+ (get_constant("separation") * (life - 1))
	)
	rect_size = Vector2(x_container_rect_size, new_icon_size_flag.y)


# Use private var icon_size_flag to set the icon size
# @returns Vector2 - all type of lenght
func get_icon_size_flag() -> Vector2:
	match icon_size_flag:
		"small":
			return Vector2(12, 12)
		"medium":
			return Vector2(24, 24)
		"large":
			return Vector2(32, 32)
		_:
			return Vector2(12, 12)
