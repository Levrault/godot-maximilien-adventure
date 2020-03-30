# Basic enemi that make a simple left to right patrol
extends Enemy

onready var Physics2D: Physics2D = $Physics2D


func _ready() -> void:
	# signal
	$AnimationPlayer.connect("animation_finished", self, "_on_Animation_finished")
	$JumpingDamageZone.connect("getting_kill", self, "_on_Death")

	# state change
	._initialize_state("Patrol")


func _on_Death() -> void:
	$JumpingDamageZone.queue_free()
	$HitBox.queue_free()
	_change_state("Death")


func _physics_process(delta: float) -> void:
	current_state.update(self, delta)
	Physics2D.compute_gravity(self, delta)
