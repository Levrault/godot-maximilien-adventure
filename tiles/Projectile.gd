# Simple projectiles
extends KinematicBody2D
class_name Projectile

export (Vector2) var FORCE: Vector2 = Vector2(0, 500)


func _ready() -> void:
	$WallDetect.connect("body_entered", self, "_on_Body_entered")


func _physics_process(delta: float) -> void:
	move_and_collide(FORCE * delta)


func _on_LifeTimer_timeout() -> void:
	queue_free()


func _on_Body_entered(body) -> void:
	queue_free()
