extends Sprite

const VALUE := 3.0
const DURATION := 2.0
enum { FORWARD, BACKWARD }
var index = FORWARD
var from = 0
var to = 0


func _ready() -> void:
	$Tween.connect("tween_completed", self, "_on_Tween_completed")
	from = position
	to = Vector2(position.x + VALUE, position.y)

	$Tween.interpolate_property(self, "position", from, to, 2, Tween.EASE_IN, Tween.EASE_OUT)

	$Tween.start()


func _on_Tween_completed(object: Object, key: NodePath) -> void:
	index += 1
	if index > BACKWARD:
		index = FORWARD

	match index:
		FORWARD:
			$Tween.interpolate_property(
				self, "position", from, to, DURATION, Tween.EASE_IN, Tween.EASE_OUT
			)
		BACKWARD:
			$Tween.interpolate_property(
				self, "position", to, from, DURATION, Tween.EASE_IN, Tween.EASE_OUT
			)

	$Tween.start()
