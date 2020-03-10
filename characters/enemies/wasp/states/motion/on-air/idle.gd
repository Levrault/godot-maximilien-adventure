# Wasp chilling out until the player come nearby
extends Motion


func enter(host: Wasp) -> void:
	host.get_node("AnimationPlayer").play("Idle")


# @emit finished(Alert)
func update(host: Wasp, delta: float) -> void:
	if host.has_target:
		emit_signal("finished", "Alert")
	host.velocity = Vector2.ZERO
