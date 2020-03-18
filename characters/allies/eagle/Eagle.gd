extends Character
class_name Eagle

# cache
onready var Physics2D: Node2D = $Physics2D

export (float) var patrol_distance = 200.0
var min_distance := 0.0
var max_distance := 0.0


func _ready() -> void:
	gravity_enable = false

	# state change
	if patrol_distance > 0:
		min_distance = position.x - patrol_distance
		max_distance = position.x
		._initialize_state("Patrol")
	else:
		._initialize_state("Idle")


func _physics_process(delta: float) -> void:
	current_state.update(self, delta)
	Physics2D.compute_gravity(self, delta)
