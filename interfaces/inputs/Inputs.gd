# Input key visualizer, management between keyboard and controller
tool
extends Control
class_name Inputs

export (bool) var has_text := true
export (String, "INPUT_TALK", "INPUT_JUMP", "INPUT_NEXT", "INPUT_CLOSE", "INPUT_OPEN", "INPUT_READ") var action := "INPUT_TALK" setget set_action
export (
	String,
	"F",
	"E",
	"W",
	"A",
	"S",
	"D",
	"Arrow_UP",
	"Arrow_LEFT",
	"Arrow_DOWN",
	"Arrow_RIGHT",
	"Space",
	"CTRL",
	"Shift"
) var selected_keyboard_input := "F"
export (String, "A", "X", "B", "Y") var selected_controller_input := "A"
export (String, "Keyboard", "Xbox") var debug_selected_controller = "Keyboard"

var selected_controller := ControllerManager.KEYBOARD
var key_mapping: Dictionary = {}
var editor_previous_keyboard_input := "F"
var editor_previous_controller_input = ControllerManager.KEYBOARD
var editor_previous_action := "TALK"
var editor_previous_has_text := true


func _ready() -> void:
	# signals
	ControllerManager.connect("controller_changed", self, "_on_Input_method_changed")
	$Timer.connect("timeout", self, "_on_Timeout")

	# hide all key before show

	if not Engine.editor_hint:
		for container in $HBoxContainer/Controller.get_children():
			container.visible = false

	# action
	$HBoxContainer/Action.text = TranslationServer.translate(action)
	$HBoxContainer/Action.visible = has_text

	# controller
	if not Engine.editor_hint:
		_on_Input_method_changed(ControllerManager.controller)
	else:
		_on_Input_method_changed(ControllerManager.KEYBOARD)


# Live editing
# @param {float} delta
func _process(delta: float) -> void:
	if Engine.editor_hint:
		var current_input: String = (
			selected_keyboard_input
			if selected_controller == ControllerManager.KEYBOARD
			else selected_controller_input
		)
		if (
			editor_previous_keyboard_input != current_input
			or editor_previous_controller_input != selected_controller
			or editor_previous_action != action
			or editor_previous_has_text != has_text
		):
			# set previous editor variables
			editor_previous_keyboard_input = current_input
			editor_previous_controller_input = selected_controller
			editor_previous_has_text = has_text
			editor_previous_action = action

			# set actions
			$HBoxContainer/Action.text = TranslationServer.translate(action)
			$HBoxContainer/Action.visible = has_text

			# re-hide everything
			for container in $HBoxContainer/Controller.get_children():
				container.visible = false
			for container in $HBoxContainer/Controller.get_node(selected_controller).get_children():
				container.visible = false

			# re-init controller
			var controller_keys := _init_controller()
			key_mapping = _init_key(controller_keys)
			key_mapping["Normal"].visible = true
			key_mapping["Pressed"].visible = false


# display current controller (xbox, keyboard etc.)
# @returns {Array}
func _init_controller() -> Array:
	var containers: Array = []
	for container in $HBoxContainer/Controller.get_children():
		if container.get_name() == selected_controller:
			containers = container.get_children()
			container.visible = true
		else:
			container.visible = false

	return containers


# set normal and pressed key image to dictionnary
# @params {array} containers
# @return {Dictionary}
func _init_key(containers: Array) -> Dictionary:
	var key_to_map: Dictionary = {}
	var current_selected_key := (
		selected_keyboard_input
		if selected_controller == ControllerManager.KEYBOARD
		else selected_controller_input
	)
	for key_container in containers:
		if key_container.get_name() == current_selected_key:
			key_container.visible = true
			for key_state in key_container.get_children():
				key_to_map[key_state.get_name()] = key_state
	return key_to_map


# Update device display
# @param {String} device
# signal controller_changed - ControllerManager
func _on_Input_method_changed(device: String) -> void:
	selected_controller = device
	if ProjectSettings.get_setting("Debug/debug_mode"):
		selected_controller = debug_selected_controller
	if not Engine.editor_hint:
		editor_previous_keyboard_input = (
			selected_keyboard_input
			if selected_controller == ControllerManager.KEYBOARD
			else selected_controller_input
		)
		editor_previous_controller_input = selected_controller
		editor_previous_action = action
		editor_previous_has_text = has_text
	var controller_keys := _init_controller()
	key_mapping = _init_key(controller_keys)
	key_mapping["Normal"].visible = true
	key_mapping["Pressed"].visible = false


# show/hide key
# @signal timeout
func _on_Timeout() -> void:
	if not key_mapping.has("Normal"):
		return
	key_mapping["Normal"].visible = not key_mapping["Normal"].visible
	key_mapping["Pressed"].visible = not key_mapping["Pressed"].visible


# @param {String} new_action
func set_action(new_action: String) -> void:
	action = new_action
	$HBoxContainer/Action.text = TranslationServer.translate(action)


# start timer
func start_timer() -> void:
	$Timer.wait_time = 1
	$Timer.start()


# stop timer
func stop_timer() -> void:
	$Timer.stop()
	key_mapping["Normal"].visible = true
	key_mapping["Pressed"].visible = false


# show
func show() -> void:
	start_timer()
	$Tween.interpolate_property(
		self,
		"modulate",
		Color(0, 0, 0, 0),
		Color(1, 1, 1, 1),
		0.2,
		Tween.TRANS_LINEAR,
		Tween.TRANS_LINEAR
	)
	$Tween.start()


# hide
func hide() -> void:
	$Tween.interpolate_property(
		self,
		"modulate",
		Color(1, 1, 1, 1),
		Color(0, 0, 0, 0),
		0.2,
		Tween.TRANS_LINEAR,
		Tween.TRANS_LINEAR
	)
	$Tween.start()
	stop_timer()
