# Manage damage on a character.
# When touched, a knockback force is apply to the character.
extends Area2D
class_name DamageZone

export (float) var amount := 25.0
export (int, FLAGS) var MASK := 2


func _ready():
	self.connect("body_entered", self, "_on_Body_entered")


# Set damage and display slash effect
# @signal body_entered
# @param {Character} body - a character
func _on_Body_entered(body: Character) -> void:
	#	ennemy and player
	if not body.is_invincible:
		make_damage(body)


# Damage character
# @param {Character} body
func make_damage(body: Character) -> void:
	body.get_node("Health").take_damage(amount)
