extends StaticBody2D
class_name LevelLimit


func _ready():
	LevelManager.connect("limit_disabled", self, "_on_Disabled")


func _on_Disabled() -> void:
	set_collision_layer_bit(0, false)
