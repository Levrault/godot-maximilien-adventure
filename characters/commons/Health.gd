"""
Manage health of the character.
"""
extends Node2D
class_name Health

# signal emitted when the health change
signal health_changed(new_health)
# signal emitted when the max health change
signal max_health_changed(new_health)
# signal emitted when a character take damage
signal take_damage(alive)

export(float) var max_health: float = 100.0
var health: float = 0.0


func _ready() -> void:
	health = max_health
	emit_signal('max_health_changed', max_health)
	emit_signal('health_changed', health)


"""
Debug function to simulate hit/recover health
"""
func _input(event: InputEvent) -> void:
	if ProjectSettings.get_setting('Debug/debug_mode') and get_parent() is Player:
		if event.is_action_pressed('simulate_getting_hit_player'):
			take_damage(25.0)
		elif event.is_action_pressed('simulate_kill_player'):
			take_damage(100.0)
		elif event.is_action_pressed('simulate_recover_health_player'):
			recover_health(25.0)


"""
Damage the character.

@param {float} amount - amount of health to remove
"""
func take_damage(amount: float) -> void:
	var is_alive: bool = true
	health -= amount
	# if the character has no health	
	if health <= 0:
		health = 0
		is_alive = false

	emit_signal('health_changed', health)
	emit_signal('take_damage', is_alive)
	print('%s took %s damage. Health: %s/%s' % [get_path(), amount, health, max_health])


"""
Health the character.

@param {float} amount - amount of health to add
"""
func recover_health(amount: float) -> void:
	health += amount
	if health > max_health:
		health = max_health
	emit_signal('health_changed', health)
	print('%s recovered %s health. Health: %s/%s' % [get_path(), amount, health, max_health])


"""
Health the character.

@param {float} amount - amount of health to add
"""
func reset() -> void:
	recover_health(max_health)