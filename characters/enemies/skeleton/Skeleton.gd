extends Character

# cache
onready var Physics2D: Node2D = $Physics2D

# I.A.
#warning-ignore:unused_class_variable
var has_target: bool = false
var target_position: Vector2 = Vector2()

const TARGET_MIN_DISTANCE: float = 20.0
const FOLLOW_RANGE: float = 100.0
const ATTACK_RANGE: float = 30.0


func _ready() -> void:
	# signal
	$AnimationPlayer.connect('animation_finished', self, '_on_Animation_finished')
	$States/Death/Explosion.connect('exploded', self, 'queue_free')
	$JumpingDamageZone.connect('getting_kill', self, '_on_Death')
	
	# state change
	._initialize_state('Patrol')


# Connect to Health
func _on_Death() -> void:
	$HitBox.queue_free()
	$JumpingDamageZone.queue_free()
	_change_state('Death')


func _physics_process(delta: float) -> void:
	current_state.update(self, delta)
	Physics2D.compute_gravity(self, delta)


func _on_player_position_changed(new_position: Vector2) -> void:
	target_position = new_position
	has_target = position.distance_to(target_position) <= FOLLOW_RANGE