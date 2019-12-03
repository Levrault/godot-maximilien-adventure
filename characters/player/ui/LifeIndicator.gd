tool
extends HBoxContainer

export(String, 'small', 'medium', 'large') var icon_size_flag = 'small'
var Icon = preload('res://characters/player/ui/PlayerIcon.tscn')

# debug
var previous_icon_size: String = 'small'

func _ready() -> void:
	GameManager.connect('player_life', self, '_on_Player_life_change')
	_on_Player_life_change(GameManager.player_life)
	
	
# warning-ignore:unused_argument
func _process(delta: float) -> void:
	if Engine.editor_hint:
		if previous_icon_size != icon_size_flag:
			previous_icon_size = icon_size_flag
			_on_Player_life_change(3)


func _on_Player_life_change(life: int) -> void:
	# clear previous icon
	for icon in get_children():
		icon.queue_free()
	
	# new values
	var i := 1
	var new_icon_size_flag = get_icon_size_flag()
	var x_container_rect_size: float = 0
	while(i <= life):
		var icon = Icon.instance()
		icon.rect_size = new_icon_size_flag
		icon.rect_min_size = new_icon_size_flag
		add_child(icon)
		i+=1
		
	# compute vbox rect_size with all icon and separation
	compute_rect_size(life)


func compute_rect_size(life: int) -> void:
	var new_icon_size_flag = get_icon_size_flag()
	var x_container_rect_size = (new_icon_size_flag.x * life) + (get_constant('separation') * (life -1))
	rect_size = Vector2(x_container_rect_size, new_icon_size_flag.y)


func get_icon_size_flag() -> Vector2:
	match icon_size_flag:
		'small':
			return Vector2(12, 12)
		'medium':
			return Vector2(24, 24)
		'large':
			return Vector2(32, 32)
		_:
			return Vector2(12, 12)
