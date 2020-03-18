extends Enemy
class_name Slime

# cache
onready var Physics2D: Node2D = $Physics2D

#warning-ignore:unused_class_variable


func _ready() -> void:
	$AnimationPlayer.connect("animation_finished", self, "_on_Animation_finished")
	$Health.connect('take_damage', self, '_on_Getting_hit')
	$CooldownTimer.connect("timeout", self, "_on_Cooldown_timeout")
	$AttackZone.connect("body_entered", self, "_on_Body_entered")
	$AttackZone.connect("body_exited", self, "_on_Body_exited")
	_initialize_state()


# Connect to Health
func _on_Getting_hit(alive: bool) -> void:
	print("hit")
	is_alive = alive
	if alive:
		_change_state('GettingHit')
	else:
		_change_state('Death')


func _physics_process(delta: float) -> void:
	current_state.update(self, delta)
	Physics2D.compute_gravity(self, delta)


func _on_Body_entered(body: Player) -> void:
	has_target = true


func _on_Body_exited(body: Player) -> void:
	has_target = false
