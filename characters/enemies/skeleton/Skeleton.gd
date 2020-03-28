# Basic enemi that make a simple left to right patrol
extends Enemy

onready var Physics2D: Physics2D = $Physics2D
var jump_count := 0


func _ready() -> void:
	# signal
	$AnimationPlayer.connect("animation_finished", self, "_on_Animation_finished")
	$JumpingDamageZone.connect("getting_kill", self, "_on_Damage")
	$JumpingDamageZone.connect("body_exited", self, "_on_Hitbox_enable")

	# state change
	._initialize_state("Patrol")


func _on_Damage() -> void:
	$FlashPlayer.play("Flash")
	jump_count += 1
	if jump_count >= 2:
		_on_Death()
	else:
		$HitBox.set_monitoring(false)


func _on_Hitbox_enable(body: Player) -> void:
	$HitBox.set_monitoring(true)


# Connect to Health
func _on_Death() -> void:
	$JumpingDamageZone.queue_free()
	$HitBox.queue_free()
	_change_state("Death")


func _physics_process(delta: float) -> void:
	current_state.update(self, delta)
	Physics2D.compute_gravity(self, delta)
