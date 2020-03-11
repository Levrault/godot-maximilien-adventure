# Dialogue Box Factory, will create all needed dialogue box and manage
# their suppression.
extends Control
class_name Dialogue

const DIALOGUE_BOX_SCENE: Resource = preload("res://dialogue/DialogueBox.tscn")
var dialogues := []
var rect_position_y := 0.0


func _ready() -> void:
	rect_position_y = rect_position.y


# Play dialog autio
# param {bool} is_playing
func _on_Dialogue_audio(is_playing: bool) -> void:
	if is_playing:
		get_parent().get_node("AudioStreamPlayer").play()
	else:
		get_parent().get_node("AudioStreamPlayer").stop()


# Delete previous dialogue box instance and show the next one.
# Update the dialogue input button if this is the last one.
func _next_dialogue() -> void:
	var previous_dialogue = dialogues.pop_back()
	previous_dialogue.queue_free()

	# if there no dialogue left
	if dialogues.empty():
		DialogueManager.end_dialogue()
		rect_position.y = rect_position_y
	else:
		var size := dialogues.size()
		dialogues[size - 1].show()
		if size == 1 and dialogues[size - 1].is_dialogue_finished:
			dialogues[size - 1].last_dialogue()


# Will instanciate all the dialogue box and show the first one.
# @param {String} npc_name
# @param {Array} dialogue_contents
func start(npc_name: String, dialogue_contents: Array) -> void:
	# create instance
	for dialogue in dialogue_contents:
		var box := DIALOGUE_BOX_SCENE.instance()
		box.set_dialogue_value(npc_name, dialogue)
		add_child(box)
		dialogues.append(box)
		box.hide()

	# show the first dialogue
	dialogues[dialogues.size() - 1].show()


# Display next dialogue box or next sentence of the current dialogue box
func next() -> void:
	var previous_dialogue = dialogues[dialogues.size() - 1]
	if previous_dialogue.is_dialogue_finished:
		_next_dialogue()
	else:
		previous_dialogue.next_sentence()
