extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	for enemy in $World/Enemies.get_children():
		$World/Player.connect('player_position_changed', enemy, '_on_player_Position_changed')
