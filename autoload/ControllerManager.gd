extends Node
signal controller_changed(controller)

const KEYBOARD := "Keyboard"
const XBOX := "Xbox"
var controller := KEYBOARD setget set_controller


func _ready() -> void:
	Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")

	# # set input
	# if not Input.get_connected_joypads().empty():
	# 	_on_joy_connection_changed(Input.get_connected_joypads()[0], true)


# @param {int} device_id
# @param {bool} connected
# @signal joy_connection_changed
# @emit controller_changed
func _on_joy_connection_changed(device_id, connected) -> void:
	if connected:
		set_controller(XBOX)
	else:
		set_controller(KEYBOARD)


# @param {String} new_controller
# @emit controller_changed
func set_controller(new_controller) -> void:
	print("Controller: set %s" % [new_controller])
	controller = new_controller
	emit_signal("controller_changed", controller)


func _input(event: InputEvent) -> void:
	if controller != KEYBOARD and event is InputEventKey:
		set_controller(KEYBOARD)
	elif controller != XBOX:
		if event is InputEventJoypadButton or event is InputEventJoypadMotion:
			set_controller(ControllerManager.XBOX)
