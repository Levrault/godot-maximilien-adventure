extends State
class_name GettingHit

export (Resource) var stream = null
const SPEED := 175
var velocity := Vector2(140, 0)


func _on_Timeout(host: Slime) -> void:
	if host.is_alive:
		emit_signal("finished", "Follow")


func enter(host: Slime) -> void:
	$Timer.connect("timeout", self, "_on_Timeout", [host])
	$Timer.start()

	play_sound(host, stream, rng.randf_range(0.95, 1.15))

	host.get_node("AnimationPlayer").play("GettingHit")
	host.can_attack = false
	velocity = Vector2(SPEED * host.look_direction.x * -1, 0)
	host.velocity.x = velocity.x * -1


func exit(host: Slime) -> void:
	$Timer.disconnect("timeout", self, "_on_Timeout")
	if host.is_alive:
		host.can_attack = true


func update(host: Slime, delta: float) -> void:
	if not host.is_alive:
		emit_signal("finished", "Death")
	host.velocity = velocity
