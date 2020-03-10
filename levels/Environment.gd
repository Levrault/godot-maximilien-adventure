extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	find_tilemaps(get_node("/root"), Color(1, 1, 1, 1))


func find_tilemaps(node, color) -> void:
	for child in node.get_children():
		if not child is TileMap:
			if child.get_child_count() > 0:
				find_tilemaps(child, color)
		else:
			child.modulate = color
