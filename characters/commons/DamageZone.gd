"""
Manage damage on a character.
When touched, a knockback force is apply to the character.
"""
extends Area2D
class_name DamageZone

export(float) var amount := 25.0 setget set_amount
export(int, FLAGS) var MASK := 2


func _ready():
	self.connect("body_entered", self, "_on_Body_entered")


"""
Set damage and display slash effect

@signal body_entered

@param {Character} body - a character
"""
func _on_Body_entered(body: Character) -> void:
	#	ennemy and player
	if not body.is_invincible:
		make_damage(body)
	

"""
Knockback character
"""
func make_damage(body: Character) -> void:
#	var direction: int = -1 if body.get_global_position() > get_parent().get_global_position() else 1
#	body.knockback_force = KNOCKBACK_FORCE
	body.get_node("Health").take_damage(amount)


"""
Damage amount for the hitted character.
"""
func set_amount(new_amount):
	amount = new_amount


