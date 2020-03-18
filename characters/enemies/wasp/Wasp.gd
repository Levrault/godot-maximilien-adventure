# Flying enemy that will track the player if he goes in her dectection zone
extends Enemy
class_name Wasp

# cache
onready var Physics2D: Physics2D = $Physics2D

# I.A.
const TARGET_MIN_DISTANCE := 20.0
const FOLLOW_RANGE := 175.0
var starting_position := Vector2.ZERO


func _ready() -> void:
	# signal
	$AnimationPlayer.connect("animation_finished", self, "_on_Animation_finished")
	$JumpingDamageZone.connect("getting_kill", self, "_on_Death")

	# flying type
	gravity_enable = false

	starting_position = position

	# state change
	._initialize_state()


# Kill the wasp
# @signal getting_kill
func _on_Death() -> void:
	$HitBox.queue_free()
	$JumpingDamageZone.queue_free()
	_change_state("Death")


# compute state and physic
# @param {float} delta
func _physics_process(delta: float) -> void:
	current_state.update(self, delta)
	Physics2D.compute_gravity(self, delta)


# @signal player_global_position_changed - through game.gd
func _on_player_Position_changed(new_position: Vector2) -> void:
	._on_player_Position_changed(new_position)
	has_target = position.distance_to(target_position) <= FOLLOW_RANGE
