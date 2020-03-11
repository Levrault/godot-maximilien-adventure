extends Character
class_name Enemy

# I.A.
var has_target := false
var has_hit_player := false
var target_position := Vector2()

var rng = RandomNumberGenerator.new()


# set new player position
# @signal player_global_position_changed - through game.gd
# @param {Vector2} new_position
func _on_player_Position_changed(new_position: Vector2) -> void:
	target_position = new_position


# make the enemy drop a health package
func _drop_health_pack() -> void:
	rng.randomize()
	var id: int = rng.randi_range(0, 1)
	if bool(id):
		DropItemManager.drop_health_pack(get_parent(), position)
