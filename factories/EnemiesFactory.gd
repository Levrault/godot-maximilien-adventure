extends Factory

func _ready() -> void:
	._ready()
	
		# all enemy should know the player position
	for node in nodes:
		PlayerManager.get_player().connect('player_position_changed', node, '_on_player_Position_changed')