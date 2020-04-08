# Main boss, need to be hit three times to be defeated
extends Enemy
class_name Slime

onready var Physics2D: Node2D = $Physics2D
var wait_before_sight := true
var room_center_point := Vector2.ZERO


func _ready() -> void:
	$AnimationPlayer.connect("animation_finished", self, "_on_Animation_finished")
	$Health.connect('take_damage', self, '_on_Getting_hit')
	$CooldownTimer.connect("timeout", self, "_on_Cooldown_timeout")
	$DecisionTimer.connect("timeout", self, "_on_Decision_timeout")

	if has_node("AttackZone"):
		$AttackZone.connect("body_entered", self, "_on_Body_entered")
		$AttackZone.connect("body_exited", self, "_on_Body_exited")

	if get_tree().has_group("boss_room"):
		room_center_point = get_tree().get_nodes_in_group("boss_room").pop_front().position

	_initialize_state()


# @param {bool} alive
# @signal take_damage
func _on_Getting_hit(alive: bool) -> void:
	is_alive = alive
	if alive:
		_change_state('GettingHit')
	else:
		_change_state('Death')


# Small delay when detecting the player and begin to move
# @signal timeout
func _on_Decision_timeout() -> void:
	wait_before_sight = false


func _physics_process(delta: float) -> void:
	current_state.update(self, delta)
	Physics2D.compute_gravity(self, delta)


# @signal body_entered
func _on_Body_entered(body: Player) -> void:
	has_target = true
	$DecisionTimer.start()
	if wait_before_sight:
		$ExclamationPoint.show()


# @signal body_exited
func _on_Body_exited(body: Player) -> void:
	has_target = false
