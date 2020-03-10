# Top tree z-index management
extends Sprite

const RANGE := 35.0


func _ready():
	PlayerManager.player.connect(
		"player_global_position_changed", self, "_on_player_Position_changed"
	)
	PlayerManager.player.connect("state_changed", self, "_on_player_State_changed")
	z_index = 2


# @signal player_global_position_changed 
func _on_player_Position_changed(new_position: Vector2) -> void:
	if $Position2D.global_position.distance_to(new_position) > RANGE and z_index != 2:
		z_index = 2


# @signal state_changed 
func _on_player_State_changed(state: String) -> void:
	if state != "Jump" and z_index != 3:
		z_index = 3
