extends Area2D

# one-hit enemy
signal getting_hit
export (float) var amount := 25.0
export (float) var knockback_force_y := -650.0


func _init() -> void:
	set_collision_layer_bit(0, false)
	set_collision_mask_bit(0, false)
	set_collision_mask_bit(1, false)


func _ready():
	self.connect("body_entered", self, "_on_Body_enter")


# Make the player bounce when colliding this zone
# @signal getting_kill - for the character with the bouncing zone
func _on_Body_enter(body: Player) -> void:
	if body.velocity.y > 0:
		body.controlled_jump = false
		body.velocity.y = knockback_force_y
		body._change_state("Jump")
		owner.get_node('Health').take_damage(amount)
		emit_signal("getting_hit")
