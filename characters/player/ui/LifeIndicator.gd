extends HBoxContainer
var Icon = preload('res://characters/player/ui/PlayerIcon.tscn')


func _ready() -> void:
	GameManager.connect('player_life', self, '_on_Player_life_change')
	_on_Player_life_change(GameManager.player_life)


func _on_Player_life_change(life: int) -> void:
	# clear previous icon
	for icon in get_children():
		icon.queue_free()
	
	# new values
	var i := 0
	while(i < life):
		var icon = Icon.instance()
		icon.rect_size = Vector2(12, 12)
		icon.rect_min_size = Vector2(12, 12)
		add_child(icon)
		i+=1