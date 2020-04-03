# Dialogue Box. Manage npc_name and send dialogue sentenes to dialogue text.
tool
extends Control
class_name DialogBox

# switch to next sentence
signal next_dialogue_text_sentence

export (String) var npc_name = "NAME"
export (String) var dialog_key = "DIALOGUE_PLACEHOLDER"
export (bool) var has_input := true

const LINE_HEIGHT: float = 20.0
var rect_position_y: float = 0.0

# editor
var editor_previous_dialog_key: String = "DIALOGUE_PLACEHOLDER"
var editor_previous_npc_name: String = "NAME"
var is_dialogue_finished: bool = false


func _ready():
	var dialogue_text := $PanelContainer/VBoxContainer/Text

	dialogue_text.connect("dialogue_text_completed", self, "_on_Dialogue_text_completed")
	dialogue_text.connect("dialogue_text_line_number", self, "_on_Sentences_count_change")
	self.connect("next_dialogue_text_sentence", dialogue_text, "_on_Next_sentence")

	rect_position_y = get_parent().rect_position.y

	set_dialogue_value(
		TranslationServer.translate(npc_name), TranslationServer.translate(dialog_key)
	)
	if has_input:
		$PanelContainer/Inputs.start_timer()
	else:
		$PanelContainer/Inputs.hide()


# Does dialogue text has displayed all sentences ?
func _on_Dialogue_text_completed() -> void:
	is_dialogue_finished = true


# Move dialogue box to fit the number of lines.
# If there is 4 lines, the box will be resize to 80 (20px height by line)
# If there is 3 lines, the box will be resize to 60.
# We re-compute the position from to top panel. So more there is lines, the less we need to
# move the box
# @param {int} lines_number
func _on_Sentences_count_change(lines_number: float) -> void:
	rect_size.y = (lines_number * LINE_HEIGHT) + LINE_HEIGHT
	# more there is line, the less the position must be reduce. 
	get_parent().rect_position.y = rect_position_y + (75 - lines_number * 20)


# Update DialogueBox element in editor mode
# @param {float} delta
func _process(delta) -> void:
	if Engine.editor_hint:
		if editor_previous_dialog_key != dialog_key or editor_previous_npc_name != npc_name:
			editor_previous_dialog_key = dialog_key
			editor_previous_npc_name = npc_name
			set_dialogue_value(npc_name, TranslationServer.translate(dialog_key))


# Set npc name and send translated sentences to dialogue text
# @param {string} new_npc_name
# @param {string} new_dialogue_key
func set_dialogue_value(new_npc_name: String, new_dialog_key: String) -> void:
	npc_name = new_npc_name
	dialog_key = new_dialog_key
	$PanelContainer/VBoxContainer/Name.text = TranslationServer.translate(npc_name)
	$PanelContainer/VBoxContainer/Text.init(TranslationServer.translate(dialog_key))


# Update inputs fording when this is the last dialogue to be displayed
func last_dialogue() -> void:
	$PanelContainer/Inputs.action = "CLOSE"


# Next dialogue text sentence
func next_sentence() -> void:
	emit_signal("next_dialogue_text_sentence")


# Show this dialogue box
func show() -> void:
	$AnimationPlayer.play("Show")
	emit_signal("next_dialogue_text_sentence")


# Hide this dialogue box
func hide() -> void:
	$AnimationPlayer.play("Hide")
