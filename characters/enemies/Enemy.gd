extends Character
class_name Enemy

# I.A.
#warning-ignore:unused_class_variable
var has_target: bool = false
var target_position: Vector2 = Vector2()

const TARGET_MIN_DISTANCE: float = 20.0
const ATTACK_RANGE: float = 100.0


func _on_player_Position_changed(new_position: Vector2) -> void:
	target_position = new_position
#	has_target = position.distance_to(target_position) <= ATTACK_RANGE