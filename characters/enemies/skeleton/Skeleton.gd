extends Enemy

# cache
onready var Physics2D: Physics2D = $Physics2D

func _ready() -> void:
	# signal
	$AnimationPlayer.connect("animation_finished", self, "_on_Animation_finished")
	$JumpingDamageZone.connect("getting_kill", self, "_on_Death")
	
	# state change
	._initialize_state("Patrol")


# Connect to Health
func _on_Death() -> void:
	$HitBox.queue_free()
	$JumpingDamageZone.queue_free()
	_change_state("Death")


func _physics_process(delta: float) -> void:
	current_state.update(self, delta)
	Physics2D.compute_gravity(self, delta)
