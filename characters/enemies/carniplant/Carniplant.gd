# A static enemy that will attach the player when it goes nearby
extends Enemy
class_name Carniplant


func _ready() -> void:
	# signal
	$AnimationPlayer.connect("animation_finished", self, "_on_Animation_finished")
	$CooldownTimer.connect("timeout", self, "_on_Cooldown_timeout")
	$AttackDetection.connect("body_entered", self, "_on_Player_entered")
	$AttackDetection.connect("body_exited", self, "_on_Player_exited")
	$AnimationPlayer.play("SETUP")

	# state change
	._initialize_state()


# Update current state
func _physics_process(delta: float) -> void:
	current_state.update(self, delta)


# Stop attacking until the cooldown
func _on_Cooldown_timeout() -> void:
	can_attack = true


# Attack when a player is nearby
func _on_Player_entered(body: Player) -> void:
	has_target = true
	can_attack = $CooldownTimer.time_left == 0


func _on_Player_exited(body: Player) -> void:
	has_target = false
	can_attack = false
