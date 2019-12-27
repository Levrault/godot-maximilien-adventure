"""
Sprite with a floating effect
"""
extends Sprite
class_name floatingSprite

const move := 5.0
var going_up := true


func _ready() -> void:
	$Tween.connect("tween_completed", self, "_on_Tween_completed")
	_on_floating()


"""
Move the sprite
"""
func _on_floating() -> void:
	var new_position = Vector2(position.x, position.y + move) if going_up else Vector2(position.x, position.y - move)
	$Tween.interpolate_property(self, "position", position, new_position, 0.5, Tween.EASE_IN, Tween.EASE_OUT)
	$Tween.start()



"""
@signal tween_completed
"""
func _on_Tween_completed(object: Object, key: NodePath) -> void:
	going_up = !going_up
	_on_floating()