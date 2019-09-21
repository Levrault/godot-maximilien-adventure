extends Enemy

# cache
onready var Physics2D: Physics2D = $Physics2D

# I.A.
#warning-ignore:unused_class_variable
const TARGET_MIN_DISTANCE: float = 20.0
const FOLLOW_RANGE: float = 175.0
var starting_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	# signal
	$AnimationPlayer.connect('animation_finished', self, '_on_Animation_finished')
	$JumpingDamageZone.connect('getting_kill', self, '_on_Death')

	# flying type
	gravity_enable = false
	
	starting_position = position
	
	# state change
	._initialize_state()


# Connect to Health
func _on_Death() -> void:
	$HitBox.queue_free()
	$JumpingDamageZone.queue_free()
	_change_state('Death')


func _physics_process(delta: float) -> void:
	current_state.update(self, delta)
	Physics2D.compute_gravity(self, delta)


func _on_player_Position_changed(new_position: Vector2) -> void:
	._on_player_Position_changed(new_position)
	has_target = position.distance_to(target_position) <= FOLLOW_RANGE