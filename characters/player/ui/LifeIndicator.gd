extends HBoxContainer


func _ready() -> void:
	GameManager.connect('player_life', self, '_on_Player_life_change')


func _on_Player_life_change(life: int) -> void:
	$Label.text = '%s' % life