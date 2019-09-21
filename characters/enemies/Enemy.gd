extends Character
class_name Enemy

# I.A.
#warning-ignore:unused_class_variable
var has_target: bool = false
#warning-ignore:unused_class_variable
var has_hit_player: bool = false
var target_position: Vector2 = Vector2()


func _on_player_Position_changed(new_position: Vector2) -> void:
	target_position = new_position