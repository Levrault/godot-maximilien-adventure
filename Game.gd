extends Node2D

export (float) var fall_damage = 25.0
var limit_bottom: float = 0
var limit_left: float = 0
var limit_right: float = 0
var player_out_of_bound: bool = false

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
	if not player_out_of_bound:
		if _compute_player_bound(new_position):
			player_out_of_bound = true
			_on_Player_fall()


func _on_Player_fall():
	$World/Player.get_node('Health').take_damage(fall_damage)
	if $World/Player.is_alive:
		$World/Player.respawn()
	player_out_of_bound = false


func _compute_player_bound(position: Vector2) -> bool:
	return limit_bottom < position.y or limit_left > position.x or limit_right < position.x