# Manage damage on a character.
# When touched, a knockback force is apply to the character.
extends DamageZone

export (Vector2) var knockback_force := Vector2.ZERO


# Damage character
# @param {Character} body
func make_damage(body: Character) -> void:
	.make_damage(body)
	body.controllable_movement = false
	body.velocity.x = knockback_force.x * owner.look_direction.x
	body.velocity.y = -knockback_force.y
	body.snap_enable = false
