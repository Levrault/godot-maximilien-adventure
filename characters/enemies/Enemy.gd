extends Character
class_name Enemy

# I.A.
#warning-ignore:unused_class_variable
var has_target: bool = false
#warning-ignore:unused_class_variable
var has_hit_player: bool = false
var target_position: Vector2 = Vector2()

var rng = RandomNumberGenerator.new()
func _on_player_Position_changed(new_position: Vector2) -> void:
	target_position = new_position


func _drop_Aliment() -> void:
	rng.randomize()
	var id:int = rng.randi_range(0, 1)
	if bool(id):
		AlimentManager.drop_aliment(get_parent(), position)