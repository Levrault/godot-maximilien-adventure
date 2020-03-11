# Cart manager
extends StaticBody2D

onready var Movable: Node2D = $Movable
var can_move := false
var velocity := Vector2(4, 0)


func _ready() -> void:
	$Trigger.connect("body_entered", self, "_on_Player_enter")
	$WaitBeforeStartTimer.connect("timeout", self, "_on_Timeout")


# Delegate the call to child
# @param {float} delta
func _physics_process(delta: float) -> void:
	Movable.compute_movement(self, delta)


# @signal body_entered
# @emit in_cart
# @param {Player} body
func _on_Player_enter(body: Player) -> void:
	assert(body is Player)
	CartManager.in_cart()
	set_collision_layer_bit(0, false)
	body.input_enable = false
	body.global_position = $TargetPosition.global_position
	$WaitBeforeStartTimer.start()


# @signal timeout
# @emit move_cart(velocity)
func _on_Timeout() -> void:
	$AnimationPlayer.play("Move")
	can_move = true
	CartManager.move(velocity)
