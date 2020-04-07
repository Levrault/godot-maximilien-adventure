extends Enemy
class_name Slime

onready var Physics2D: Node2D = $Physics2D
var wait_before_sight := true


func _ready() -> void:
	$AnimationPlayer.connect("animation_finished", self, "_on_Animation_finished")
	$Health.connect('take_damage', self, '_on_Getting_hit')
	$CooldownTimer.connect("timeout", self, "_on_Cooldown_timeout")
	$DecisionTimer.connect("timeout", self, "_on_Decision_timeout")

	if has_node("AttackZone"):
		$AttackZone.connect("body_entered", self, "_on_Body_entered")
		$AttackZone.connect("body_exited", self, "_on_Body_exited")

	_initialize_state()


# Connect to Health
func _on_Getting_hit(alive: bool) -> void:
	is_alive = alive
	if alive:
		_change_state('GettingHit')
	else:
		_change_state('Death')


func _on_Decision_timeout() -> void:
	wait_before_sight = false


func _physics_process(delta: float) -> void:
	current_state.update(self, delta)
	Physics2D.compute_gravity(self, delta)


func _on_Body_entered(body: Player) -> void:
	has_target = true
	$DecisionTimer.start()
	if wait_before_sight:
		$ExclamationPoint.show()


func _on_Body_exited(body: Player) -> void:
	has_target = false
