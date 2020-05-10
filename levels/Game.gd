# Control everyting to set the game room
extends Node2D
class_name Game

export (float) var fall_damage = 25.0
export (String) var level_title_fallback = ""
export (String) var key = ""

var player_out_of_bound := false


# Connect enemies to player position
# Set max score
# Set level bounds
func _ready() -> void:
	if ProjectSettings.get_setting("Debug/force_save"):
		if ProgressionManager.path == "":
			ProgressionManager.path = "profile0"
			ProgressionManager.load_game()

	# all enemy should know the player position
	if $World/Enemies.get_child_count() > 0:
		for enemy in $World/Enemies.get_children():
			if enemy is Enemy:
				$World/Player.connect("player_position_changed", enemy, "_on_player_Position_changed")
	$World/Player.connect("player_global_position_changed", self, "_on_player_Position_changed")

	# set max score
	GameManager.reset_score()
	GameManager.reset_letters()
	GameManager.player_reset_life()
	GameManager.max_score = $World/Collectibles/Gems.get_child_count()
	GameManager.level = key

	# in transition
	CameraManager.transition_start("Curtain")
	UiManager.start_intro_title()
	MusicManager.change_music(key)


# When player fall of the level limit
# @signal player_global_position_changed - Player.gd
# @param {Vector2} new_position
func _on_player_Position_changed(new_position: Vector2) -> void:
	if not GameManager.player_out_of_bound:
		if _compute_player_bound(new_position):
			GameManager.player_out_of_bound = true
			_on_Player_fall()


# Replace player to the nearest ledge when falling of bound
# @param {Vector2} player_position
# @return {Vector2}
func _get_nearest_quick_spawn_point(player_position: Vector2) -> Vector2:
	# get spawn nodes
	var spawn_points = get_tree().get_nodes_in_group("block_corner")

	# assume the first spawn node is closest
	var nearest_spawn_point = spawn_points[0]

	# look through spawn nodes to see if any are closer
	for spawn_point in spawn_points:
		if (
			spawn_point.global_position.distance_to(player_position)
			< nearest_spawn_point.global_position.distance_to(player_position)
		):
			nearest_spawn_point = spawn_point

	return nearest_spawn_point.get_node("SpawnPoint").global_position


# Damage player when out of bound
func _on_Player_fall() -> void:
	if not GameManager.compute_fall_damage:
		return
	$World/Player.get_node("Health").take_damage(fall_damage)
	var spawn_point = _get_nearest_quick_spawn_point($World/Player.grounded_position)

	if $World/Player.is_alive:
		$World/Player.teleport(spawn_point)
		$World/Player._change_state("Respawn")
		GameManager.player_out_of_bound = false


# Does the player is out of bound ?
# @return {bool}
func _compute_player_bound(position: Vector2) -> bool:
	return CameraManager.previous_camera_limit_bottom < position.y
