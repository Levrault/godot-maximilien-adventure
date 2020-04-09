extends Motion
class_name GettingHit

export (Resource) var stream = null
var velocity := Vector2(SPEED, 0)
var direction := -1


func _on_Timeout(host: Slime) -> void:
	$WallDetect.connect("body_entered", self, "_on_Wall_entered", [host])


func _on_Wall_entered(body: TileMap, host: Slime) -> void:
	if host.is_alive:
		emit_signal("finished", "Follow")


func enter(host: Slime) -> void:
	$Timer.connect("timeout", self, "_on_Timeout", [host])
	$Timer.start()

	play_sound(host, stream, rng.randf_range(0.95, 1.15))

	host.get_node("AnimationPlayer").play("GettingHit")
	host.can_attack = false

	# set future direction
	if host.room_center_point.x > host.position.x:
		update_look_direction(host, Vector2(-1, 0)) 
		velocity = Vector2(SPEED, velocity.y)
	else:
		update_look_direction(host, Vector2(1, 0)) 
		velocity = Vector2(-SPEED, velocity.y)


func exit(host: Slime) -> void:
	$Timer.disconnect("timeout", self, "_on_Timeout")
	$WallDetect.disconnect("body_entered", self, "_on_Wall_entered")
	if host.is_alive:
		host.can_attack = true


func update(host: Slime, delta: float) -> void:
	if not host.is_alive:
		emit_signal("finished", "Death")
	host.velocity = velocity
