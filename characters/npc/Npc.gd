"""
Simple Npc class. Wait for the player to give a little talké
@Class Npc
"""
extends Area2D
class_name Npc

export (Array, String) var dialogue_lines = []
export (String) var npc_name = 'NPC'

func _ready() -> void:
	$AnimationPlayer.play('Idle')
	$Inputs.hide()
	
	# if we can to talk to the npc
	if not dialogue_lines.empty():
		dialogue_lines.invert()
		self.connect('body_entered', self, '_on_Player_entered')
		self.connect('body_exited', self, '_on_Player_exited')


func _on_Player_entered(body: Player) -> void:
	assert body is Player
	
	# connect dialogue signal
	DialogueManager.connect('start_dialogue', self, '_on_Start_dialogue')
	DialogueManager.connect('next_dialogue', self, '_on_Next_dialogue')
	
	# player value for dialogue
	body.can_talk = true
	body.npc_to_talk_position = position
	$Inputs.show()


func _on_Player_exited(body: Player) -> void:
	assert body is Player
	
	# disconnect dialogue signal	
	DialogueManager.disconnect('start_dialogue', self, '_on_Start_dialogue')
	DialogueManager.disconnect('next_dialogue', self, '_on_Next_dialogue')
	
	# player value for dialogue	
	body.can_talk = false
	body.npc_to_talk_position = Vector2.ZERO
	$Inputs.hide()


func _on_Start_dialogue() -> void:
	$Inputs.hide()
	$Dialogue.start(npc_name, dialogue_lines)


func _on_Next_dialogue() -> void:
	$Dialogue.next()