extends Control
tool

export (String, 'TALK', 'JUMP', 'NEXT', 'CLOSE') var action = 'TALK' setget set_action
export (String, 'F', 'E', 'W', 'A', 'S', 'D', 'Arrow_UP', 'Arrow_LEFT', 'Arrow_DOWN', 'Arrow_RIGHT', 'Space', 'CTRL', 'Shift') var selected_keyboard_input = 'F'
export (String, 'A', 'X', 'B', 'Y') var selected_controller_input = 'A'
export (String, 'Keyboard', 'XboxOne') var selected_controller: String = 'Keyboard'

var key_mapping: Dictionary = {}
var editor_previous_keyboard_input: String = 'F'
var editor_previous_controller_input: String = 'Keyboard'
var editor_previous_action: String = 'TALK'


func _ready() -> void:
	# signals
	$Timer.connect('timeout', self, '_on_Timeout')
	
	# action
	$HBoxContainer/Action.text = TranslationServer.translate(action)
	
	# controller
	if not Engine.editor_hint:
		selected_controller = GameManager.get_controller()
		editor_previous_keyboard_input = selected_keyboard_input if selected_controller == 'Keyboard' else selected_controller_input
		editor_previous_controller_input = selected_controller
		editor_previous_action = action
	var controller_keys := _init_controller()
	key_mapping = _init_key(controller_keys)
	key_mapping['Normal'].visible = true
	key_mapping['Pressed'].visible = false


#warning-ignore:unused_argument
func _process(delta) -> void:
	if Engine.editor_hint:
		var current_input:String = selected_keyboard_input if selected_controller == 'Keyboard' else selected_controller_input
		if editor_previous_keyboard_input != current_input or editor_previous_controller_input != selected_controller or editor_previous_action != action:
			# set previous editor variables
			editor_previous_keyboard_input = current_input
			editor_previous_controller_input = selected_controller
			editor_previous_action = action
			
			# set actions
			$HBoxContainer/Action.text = TranslationServer.translate(action)
			
			# re-hide everything
			for container in $HBoxContainer/Controller.get_children():
				container.visible = false
			for container in $HBoxContainer/Controller.get_node(selected_controller).get_children():
				container.visible = false

			# re-init controller
			var controller_keys := _init_controller()
			key_mapping = _init_key(controller_keys)
			key_mapping['Normal'].visible = true
			key_mapping['Pressed'].visible = false
  

"""
display current controller (xbox, keyboard etc.)
@returns {Array}
"""
func _init_controller() -> Array:
	var containers: Array = []
	for container in $HBoxContainer/Controller.get_children():
		if container.get_name() == selected_controller:
			containers = container.get_children()
			container.visible = true
		else:
			container.visible = false
		
	return containers


"""
set normal and pressed key image to dictionnary
@params {array} containers
@return {Dictionary}
"""
func _init_key(containers: Array) -> Dictionary:
	var key_to_map: Dictionary = {}
	var current_selected_key:String = selected_keyboard_input if selected_controller == 'Keyboard' else selected_controller_input
	for key_container in containers:
		if key_container.get_name() == current_selected_key:
			key_container.visible = true
			for key_state in key_container.get_children():
				key_to_map[key_state.get_name()] = key_state
	return key_to_map


func _on_Timeout() -> void:
	assert key_mapping['Normal'] != null
	assert key_mapping['Pressed'] != null
	key_mapping['Normal'].visible = !key_mapping['Normal'].visible
	key_mapping['Pressed'].visible = !key_mapping['Pressed'].visible


func set_action(new_action: String) -> void:
	action = new_action
	$HBoxContainer/Action.text = TranslationServer.translate(action)

func start_timer() -> void:
	$Timer.wait_time = 1
	$Timer.start()


func stop_timer() -> void:
	$Timer.stop()
	key_mapping['Normal'].visible = true
	key_mapping['Pressed'].visible = false


func hide() -> void:
	modulate = Color(0, 0, 0, 0)