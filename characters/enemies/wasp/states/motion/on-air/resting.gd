# Wasp will relax between patrol
extends Motion


# warning-ignore:unused_argument
func enter(host: Character) -> void:
	$Timer.connect("timeout", self, "_on_Timeout")
	$Timer.start()


func exit(host: Wasp) -> void:
	assert(host is Wasp)
	$Timer.disconnect("timeout", self, "_on_Timeout")


func update(host: Wasp, delta: float) -> void:
	host.velocity = Vector2.ZERO


# @signal timeout
# @emit finished(Idle)
func _on_Timeout() -> void:
	emit_signal("finished", "Idle")
