# Wasp will check near her detection zone to check for the player
extends Motion


func enter(host: Wasp) -> void:
	assert(host is Wasp)
	$Timer.connect("timeout", self, "_on_Timeout")
	$Timer.start()
	$ExclamationPoint.show()


func exit(host: Wasp) -> void:
	assert(host is Wasp)
	$Timer.disconnect("timeout", self, "_on_Timeout")


func update(host: Wasp, delta: float) -> void:
	host.velocity = Vector2.ZERO


# @signal timeout
# @emit finished(Patrol)
func _on_Timeout() -> void:
	emit_signal("finished", "Patrol")
