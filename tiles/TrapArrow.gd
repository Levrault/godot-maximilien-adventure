# Create and project arrow
extends Sprite

var PROJECTILE: Resource = preload("res://tiles/Projectile.tscn")


func _ready() -> void:
	$Timer.connect("timeout", self, "_on_Timeout")
	$AnimationPlayer.play("Load")


# Instantiate a new projectile
func instantiate():
	var projectile = PROJECTILE.instance()
	projectile.position = $Position2D.position
	$AnimationPlayer.play("Shoot")
	add_child(projectile)
	$Timer.start()


# Re-create new projectile
# @signal timeout
func _on_Timeout() -> void:
	$AnimationPlayer.play("Load")
