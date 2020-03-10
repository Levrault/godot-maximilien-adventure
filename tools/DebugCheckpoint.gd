extends Label

var previous_checkpoint: Vector2 = Vector2.ZERO


#warning-ignore:unused_argument
func _process(delta):
	var current_checkpoint := GameManager.get_last_checkpoint()
	if previous_checkpoint != current_checkpoint:
		previous_checkpoint = current_checkpoint
		text = "(%s, %s)" % [stepify(current_checkpoint.x, .01), stepify(current_checkpoint.y, .01)]
