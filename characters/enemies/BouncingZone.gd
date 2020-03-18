extends Area2D

# one-hit enemy
signal getting_kill
export (float) var knockback_force_y := -400.0


func _ready():
	self.connect("body_entered", self, "_on_Body_enter")


# Make the player bounce when colliding this zone
# @signal getting_kill - for the character with the bouncing zone
func _on_Body_enter(body: Player) -> void:
	if body.velocity.y > 0:
		body.controlled_jump = false
		body.velocity.y = knockback_force_y
		body._change_state("Jump")
		emit_signal("getting_kill")
