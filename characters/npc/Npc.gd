# Simple Npc class. Wait for the player to give a little talk
tool
extends Area2D
class_name Npc

signal npc_talk(name)

export (Array, String) var dialogue_lines := []
export (bool) var flip := false
export (String) var npc_name := "NPC"
export (String, "female", "male", "other", "speechless") var voice := "female"

var previous_flip := false


func _enter_tree() -> void:
	$Sprite.flip_h = flip

	if flip:
		$TalkIcon.position.x = $TalkIcon.position.x * -1


# Set NPC voice type and set dialogue if there is any
func _ready() -> void:
	$AnimationPlayer.play("Idle")
	if not Engine.editor_hint:
		$Inputs.hide()

	# if we can to talk to the npc
	if not dialogue_lines.empty():
		$TalkIcon.show()
		dialogue_lines.invert()
		self.connect("body_entered", self, "_on_Player_entered")
		self.connect("body_exited", self, "_on_Player_exited")

		match voice:
			"female":
				$AudioStreamPlayer.pitch_scale = 1.75
			"male":
				$AudioStreamPlayer.pitch_scale = 1
			"speechless":
				$AudioStreamPlayer.pitch_scale = 2.5
			_:
				$AudioStreamPlayer.pitch_scale = 1.25

	else:
		$TalkIcon.hide()


# Tools editor update
# Flip sprite
func _process(delta) -> void:
	if Engine.editor_hint:
		if flip != previous_flip:
			$Inputs.show()
			$Sprite.flip_h = flip
			previous_flip = flip
			$TalkIcon.position.x = $TalkIcon.position.x * -1


# Connect dialogue manager to the current NPC for the player to interact with.
# @signal body_entered
# @param {Player} body
func _on_Player_entered(body: Player) -> void:
	assert(body is Player)

	# connect dialogue signal
	DialogueManager.connect("start_dialogue", self, "_on_Start_dialogue")
	DialogueManager.connect("next_dialogue", self, "_on_Next_dialogue")
	DialogueManager.connect("end_dialogue", self, "_on_Dialogue_end")
	DialogueManager.connect("dialogue_audio_start", $Dialogue, "_on_Dialogue_audio", [true])
	DialogueManager.connect("dialogue_audio_stop", $Dialogue, "_on_Dialogue_audio", [false])

	# player value for dialogue
	body.can_talk = true
	body.npc_to_talk_position = position
	$Inputs.show()
	$TalkIcon.hide()


# Disconnect dialogue manager to the current NPC
# @signal body_exited
# @param {Player} body
func _on_Player_exited(body: Player) -> void:
	assert(body is Player)

	# disconnect dialogue signal
	DialogueManager.disconnect("start_dialogue", self, "_on_Start_dialogue")
	DialogueManager.disconnect("next_dialogue", self, "_on_Next_dialogue")
	DialogueManager.disconnect("end_dialogue", self, "_on_Dialogue_end")
	DialogueManager.disconnect("dialogue_audio_start", $Dialogue, "_on_Dialogue_audio")
	DialogueManager.disconnect("dialogue_audio_stop", $Dialogue, "_on_Dialogue_audio")

	# player value for dialogue
	body.can_talk = false
	body.npc_to_talk_position = Vector2.ZERO
	$TalkIcon.show()
	$Inputs.hide()


# Start dialogue
# @signal start_dialogue
func _on_Start_dialogue() -> void:
	$Inputs.hide()
	$TalkIcon.hide()
	$Dialogue.start(npc_name, dialogue_lines)
	emit_signal("npc_talk", npc_name)


# display next dialogue
func _on_Next_dialogue() -> void:
	$Dialogue.next()


# re-show inputs
func _on_Dialogue_end() -> void:
	$Inputs.show()
