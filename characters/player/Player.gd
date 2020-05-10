# Player class
extends Character
class_name Player

signal player_position_changed(new_position)
signal player_global_position_changed(new_position)
signal player_velocity(new_velocity)

# cache
onready var Physics2D: Node2D = $Physics2D
onready var Hit: Node2D = $Hit

# player params
var previous_position := Vector2.ZERO
var grounded_position := Vector2.ZERO

# state variables
var npc_to_talk_position := Vector2.ZERO
var can_talk := false
var chest_position := Vector2.ZERO
var can_open_door := false
var is_entering_door := false
var in_cart := false
var can_exit_level := true
var has_coyote_jump := false

# private
var is_waiting_for_next_dialogue := false
var can_open_chest := false
var input_enable := true
var prev_velocity := Vector2.ZERO
var should_respawn := false


func _ready() -> void:
	connect("player_velocity", $Health/HeatlhParticule, "_on_Velocity_change")
	$AnimationPlayer.connect("animation_finished", self, "_on_Animation_finished")
	$FlashPlayer.connect("animation_finished", self, "_on_Animation_finished")
	$Health.connect("take_damage", self, "_on_Getting_hit")
	$Health.connect("health_changed", $UI/PlayerHUD/HealthBar, "_on_Health_changed")
	$Health.connect("health_reset", $UI/PlayerHUD/HealthBar, "_on_Health_reset")
	$LastGroundedPosition.connect("body_exited", self, "_on_last_grounded_position_changed")
	DialogueManager.connect("end_dialogue", self, "_on_End_dialogue")
	ChestManager.connect("inactive_chest", self, "_on_Inactive_chest")
	DoorManager.connect("teleport", self, "teleport")
	PlayerManager.connect("player_retry_checkpoint", self, "retry_checkpoint")
	PlayerManager.connect("player_input_enable", self, "_on_Input_enable")

	# set camera
	assert(has_node("Camera") == true)
	CameraManager.set_camera(get_node("Camera"))
	CameraManager.connect("camera_transition_entered", self, "_on_Input_disable")
	CameraManager.connect("camera_transition_finished", self, "_on_Input_enable")

	# init
	GameManager.set_new_checkpoint(position)
	GameManager.compute_fall_damage = true
	._initialize_state()

	if ProjectSettings.get_setting("Debug/debug_mode"):
		DebugManager.set_player(self)
	if ProjectSettings.get_setting("Debug/screenshot"):
		hide()
		UiManager.player_ui(false)

	is_invincible = false
	PlayerManager.player = self


# Delegate the call to child
# @param {float} delta
func _physics_process(delta: float) -> void:
	current_state.update(self, delta)
	Physics2D.compute_gravity(self, delta)
	if is_grounded and not controllable_movement:
		knockback_force = Vector2.ZERO
		snap_enable = true
		controllable_movement = true
	if previous_position != position:
		_on_position_changed()
		_on_global_position_changed()
		_on_velocity_changed()
		if ProjectSettings.get_setting("Debug/debug_mode"):
			DebugManager.set_player_velocity(velocity)


# Hurt player
# @signal take_damage
# @param {bool} alive
func _on_Getting_hit(alive: bool) -> void:
	is_alive = alive
	Hit.get_hit(self, is_alive)


# Change state in state machine
# @param {string} state_name
func _change_state(state_name: String) -> void:
	if ProjectSettings.get_setting("Debug/debug_mode"):
		DebugManager.set_player_state(state_name)
	._change_state(state_name)


# Catch and deleg input to the state machine
# @param {InputEvent} event
func _input(event: InputEvent) -> void:
	if input_enable:
		current_state.handle_input(self, event)


# Should send the last position where the player was on the ground
# @signal body_exited
# @param {PhysicsBody2D} body
func _on_last_grounded_position_changed(body: PhysicsBody2D) -> void:
	grounded_position = global_position


# Block player input
# @signal camera_transition_finished
func _on_Input_disable() -> void:
	input_enable = false


# Block player input
# @signal player_input_enable
# @signal camera_transition_entered camera_transition_finished
func _on_Input_enable() -> void:
	input_enable = true


# Get the last player position
# @emit player_position_changed(position)
func _on_position_changed() -> void:
	previous_position = position
	emit_signal("player_position_changed", position)


# Get the last global player position
# @emit player_global_position_changed(get_global_position())
func _on_global_position_changed() -> void:
	previous_position = position
	emit_signal("player_global_position_changed", get_global_position())


# Get the last player velocity
# @emit player_velocity(veocity)
func _on_velocity_changed() -> void:
	if velocity != prev_velocity:
		prev_velocity = velocity
		emit_signal("player_velocity", velocity)


# Player has stop dialoging
# @signal end_dialogue
func _on_End_dialogue() -> void:
	is_waiting_for_next_dialogue = false


# Callback when a player has open a chest and should not be able to
# do it again
# @signal inactive_chest
func _on_Inactive_chest() -> void:
	can_open_chest = false


# Reset player data to restart to the last checkpoint
# @signal player_retry_checkpoint
func retry_checkpoint() -> void:
	position = GameManager.get_last_checkpoint()
	is_invincible = false
	$Health.reset()
	_change_state("Respawn")

	if GameManager.player_out_of_bound:
		GameManager.player_out_of_bound = false


# Teleport player to a new position
# eg. When entering a door
# @signal teleport
# @param {Vector2} new_position
func teleport(new_position: Vector2) -> void:
	global_position = new_position


# Make player invincible
# @param {bool} value
func god_mode(value: bool) -> void:
	is_invincible = value
