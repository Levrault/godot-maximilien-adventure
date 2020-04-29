# Hitbox will detect when the player collide with it. When it happends,
# it will damage the player
extends Area2D


func _ready() -> void:
	self.connect("body_entered", self, "_on_Body_enter")


# Should damage the player
# @signal body_entered
# @param {Player} body
func _on_Body_enter(body: Player) -> void:
	assert(body is Player)
	if not body.is_invincible:
		body.get_node("Health").take_damage(25)
		get_parent().has_hit_player = true
