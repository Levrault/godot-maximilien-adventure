extends Node2D


func explode() -> void:
	show()
	for child in get_children():
		child.start()
