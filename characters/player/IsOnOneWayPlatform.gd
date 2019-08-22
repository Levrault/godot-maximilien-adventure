extends Area2D
signal is_on_one_way_platform(value)


func _ready():
	self.connect('body_entered', self, '_on_Body_entered')
	self.connect('body_exited', self, '_on_Body_exited')


func _on_Body_entered(body: TileMap) -> void:
	assert body is TileMap
	emit_signal('is_on_one_way_platform', true)


func _on_Body_exited(body: TileMap) -> void:
	assert body is TileMap
	emit_signal('is_on_one_way_platform', false)