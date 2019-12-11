extends Character
class_name Player

signal player_position_changed(new_position)
signal player_global_position_changed(new_position)

#warning-ignore:unused_signal
signal player_death

# cache
onready var Physics2D: Node2D = $Physics2D
onready var Hit: Node2D = $Hit

# player params
var previous_position: Vector2 = Vector2.ZERO
var grounded_position: Vector2 = Vector2.ZERO

#warning-ignore:unused_class_variable
var npc_to_talk_position: Vector2 = Vector2.ZERO
#warning-ignore:unused_class_variable
var can_talk: bool = false
#warning-ignore:unused_class_variable
var chest_position: Vector2 = Vector2.ZERO
#warning-ignore:unused_class_variable
var can_open_door: bool = false
#warning-ignore:unused_class_variable
var is_entering_door: bool = false
#warning-ignore:unused_class_variable
var in_cart: bool = false
#warning-ignore:unused_class_variable
var can_exit_level: bool = false
#warning-ignore:unused_class_variable
var has_coyote_jump: bool = false

var is_waiting_for_next_dialogue: bool = false
var can_open_chest: bool = false
var input_enable: bool = true


func _ready() -> void:
	# Signals
	$AnimationPlayer.connect('animation_finished', self, '_on_Animation_finished')
	$Health.connect('take_damage', self, '_on_Getting_hit')
	$Health.connect('health_changed', $UI/PlayerHUD/HealthBar, '_on_Health_changed')
	$Sprite/LastGroundedPositionChecker.connect('body_exited', self, '_on_last_grounded_position_changed')
	$IsOnOneWayPlatform.connect('is_on_one_way_platform', self, '_on_One_way_plaform')
	DialogueManager.connect('end_dialogue', self, '_on_End_dialogue')
	ChestManager.connect('inactive_chest', self, '_on_Inactive_chest')
	DoorManager.connect('teleport', self, '_on_Teleport')
	CartManager.connect('in_cart', self, '_on_Cart_enter')
	PlayerManager.connect('player_retry_level', self, 'retry_level')
	PlayerManager.connect('player_input_enable', self, '_on_Input_enable')
	
	# set camera
	assert has_node('Camera') == true
	CameraManager.set_camera(get_node('Camera'))
	CameraManager.connect('camera_transition_entered', self, '_on_Input_disable')
	CameraManager.connect('camera_transition_finished', self, '_on_Input_enable')
	
	# init
	GameManager.set_new_checkpoint(position)
	._initialize_state()
	
	if ProjectSettings.get_setting('Debug/debug_mode'):
		DebugManager.set_player(self)


""" 
Delegate the call to child
@param {float} delta
"""
func _physics_process(delta: float) -> void:
	current_state.update(self, delta)
	Physics2D.compute_gravity(self, delta)
	if previous_position != position:
		_on_position_changed()
		_on_global_position_changed()
		if ProjectSettings.get_setting('Debug/debug_mode'):
			DebugManager.set_player_velocity(velocity)


""" 
Hurt player
@param {bool} alive
"""
func _on_Getting_hit(alive: bool) -> void:
	is_alive = alive
	Hit.get_hit(self, is_alive)


""" 
Change state in state machine
@param {string} state_name
"""
func _change_state(state_name: String) -> void:
	if ProjectSettings.get_setting('Debug/debug_mode'):
		DebugManager.set_player_state(state_name)
	._change_state(state_name)


""" 
Catch and deleg input to the state machine
@param {InputEvent} event
"""
func _input(event: InputEvent) -> void:
	if input_enable:
		current_state.handle_input(self, event)


"""
Should send the last position where the player was on the ground
@param {PhysicsBody2D} body
"""
#warning-ignore:unused_argument
func _on_last_grounded_position_changed(body: PhysicsBody2D) -> void:
	grounded_position = position
	DebugManager.set_player_respawn(grounded_position)


"""
Teleport player to a new position
eg. When entering a door
@param {Vector2} new_position
"""
func _on_Teleport(new_position: Vector2) -> void:
	global_position = new_position


"""
Block player input
"""
func _on_Input_disable() -> void:
	input_enable = false


"""
Block player input
"""
func _on_Input_enable() -> void:
	input_enable = true


"""
Get the last player position
"""
func _on_position_changed() -> void:
	previous_position = position
	emit_signal('player_position_changed', position)


"""
Get the last global player position
"""
func _on_global_position_changed() -> void:
	previous_position = position
	emit_signal('player_global_position_changed', get_global_position())


"""
Switch between crouch and stand collision shape
"""
func _toggle_collision_shape() -> void:
	$StandCollisionShape.disabled = !$StandCollisionShape.disabled
	$DuckCollisionShape.disabled = !$DuckCollisionShape.disabled


"""
Player has stop dialoging
"""
func _on_End_dialogue() -> void:
	is_waiting_for_next_dialogue = false


"""
Callback when a player has open a chest and should not be able to
do it again
"""
func _on_Inactive_chest() -> void:
	can_open_chest = false


"""
When a player enter in a cart and finish a level
"""
func _on_Cart_enter() -> void:
	in_cart = true


func retry_level() -> void:
	position = GameManager.get_last_checkpoint()
	$Health.reset()
	_change_state('Idle')


"""
Respawn player
"""
func respawn() -> void:
	if is_alive:
		position = grounded_position