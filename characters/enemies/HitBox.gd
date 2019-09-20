extends Area2D


func _ready():
	self.connect('body_entered', self, '_on_Body_enter')

 
func _on_Body_enter(player: Player) -> void:
	player.get_node('Health').take_damage(25)
	get_parent().has_hit_player = true