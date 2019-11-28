"""
Simple Npc class. Wait for the player to give a little talké
@Class Npc
"""
extends Area2D
class_name Npc

export (Array, String) var dialogue_lines = []
export (String) var npc_name = 'NPC'
export (String, 'female', 'male', 'other', 'speechless') var voice = 'female' 


func _ready() -> void:
	$AnimationPlayer.play('Idle')
	$Inputs.hide()
	
	# if we can to talk to the npc
	if not dialogue_lines.empty():
		dialogue_lines.invert()
		self.connect('body_entered', self, '_on_Player_entered')
		self.connect('body_exited', self, '_on_Player_exited')
		
		match voice:
			'female':
				$AudioStreamPlayer.pitch_scale = 1.75
			'male':
				$AudioStreamPlayer.pitch_scale = 1
			'speechless':
				$AudioStreamPlayer.pitch_scale = 2.5
			_:
				$AudioStreamPlayer.pitch_scale = 1.25
			
	else:
		$Icon.hide()


func _on_Player_entered(body: Player) -> void:
	assert body is Player
	
	# connect dialogue signal
	DialogueManager.connect('start_dialogue', self, '_on_Start_dialogue')
	DialogueManager.connect('next_dialogue', self, '_on_Next_dialogue')
	DialogueManager.connect('dialogue_audio_start', $Dialogue, '_on_Dialogue_audio', [true])
	DialogueManager.connect('dialogue_audio_stop', $Dialogue, '_on_Dialogue_audio', [false])
	
	# player value for dialogue
	body.can_talk = true
	body.npc_to_talk_position = position
	$Inputs.show()
	$Icon.hide()


func _on_Player_exited(body: Player) -> void:
	assert body is Player
	
	# disconnect dialogue signal	
	DialogueManager.disconnect('start_dialogue', self, '_on_Start_dialogue')
	DialogueManager.disconnect('next_dialogue', self, '_on_Next_dialogue')
	DialogueManager.disconnect('dialogue_audio_start', $Dialogue, '_on_Dialogue_audio')
	DialogueManager.disconnect('dialogue_audio_stop', $Dialogue, '_on_Dialogue_audio')

	
	# player value for dialogue	
	body.can_talk = false
	body.npc_to_talk_position = Vector2.ZERO
	$Icon.show()
	$Inputs.hide()


func _on_Start_dialogue() -> void:
	$Inputs.hide()
	$Icon.hide()
	$Dialogue.start(npc_name, dialogue_lines)


func _on_Next_dialogue() -> void:
	$Dialogue.next()