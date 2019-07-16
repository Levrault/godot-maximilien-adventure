extends Area2D

# one-hit enemy
signal getting_kill
const knockback_force_y := -400.0


func _ready():
	self.connect('body_entered', self, '_on_Body_enter')

 
func _on_Body_enter(player: Player) -> void:
	if player.velocity.y > 0:
		player.controlled_jump = false
		player.velocity.y = knockback_force_y
		player._change_state('Jump')
		emit_signal('getting_kill')