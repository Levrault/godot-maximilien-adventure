extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect('body_exited', self, '_on_Floor_exit')

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
