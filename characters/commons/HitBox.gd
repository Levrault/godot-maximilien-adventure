extends Area2D


func _ready():
	self.connect('body_entered', self, '_on_Body_enter')

 
func _on_Body_enter(Player: Player) -> void:
	print('has enter')
	pass