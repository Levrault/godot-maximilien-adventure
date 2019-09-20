extends Motion


# warning-ignore:unused_argument
func enter(host: Character) -> void:
	$Timer.connect('timeout', self, '_on_Timeout')
	$Timer.start()


# warning-ignore:unused_argument
func exit(host: Character) -> void:
	$Timer.disconnect('timeout', self, '_on_Timeout')


# warning-ignore:unused_argument
func update(host: Character, delta: float) -> void:
	host.velocity = Vector2.ZERO


func _on_Timeout() -> void:
	emit_signal('finished', 'Idle')