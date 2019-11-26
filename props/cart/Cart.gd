extends StaticBody2D

onready var Movable: Node2D = $Movable
var can_move: bool = false
var velocity: Vector2 = Vector2(4,0)

func _ready() -> void:
	$Trigger.connect('body_entered', self, '_on_Player_enter')
	$WaitBeforeStartTimer.connect('timeout', self, '_on_Timeout')


""" 
Delegate the call to child
@param {float} delta
"""
func _physics_process(delta: float) -> void:
	Movable.compute_movement(self, delta)


func _on_Player_enter(body: Player) -> void:
	assert body is Player
	CartManager.in_cart()
	set_collision_layer_bit(0, false)
	body.global_position = $PlayerPosition.global_position	
	$WaitBeforeStartTimer.start()
	

func _on_Timeout() -> void:
	$AnimationPlayer.play('Move')
	can_move = true
	CartManager.move(velocity)	