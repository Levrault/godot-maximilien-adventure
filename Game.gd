extends Node2D

signal game_over

var limit_bottom: float = 0
var limit_left: float = 0
var limit_right: float = 0

func _ready():
	# all enemy should know the player position
	for enemy in $World/Enemies.get_children():
		$World/Player.connect('player_position_changed', enemy, '_on_player_Position_changed')
	
	# Check player global position for out of bounds death
	limit_bottom = $World/Player/Camera2D.limit_bottom
	limit_left = $World/Player/Camera2D.limit_left
	limit_right = $World/Player/Camera2D.limit_right
	$World/Player.connect('player_global_position_changed', self, '_on_player_Position_changed')


func _on_player_Position_changed(new_position: Vector2) -> void:
	if limit_bottom < new_position.y or limit_left > new_position.x or limit_right < new_position.x:
		print('out of bounds')