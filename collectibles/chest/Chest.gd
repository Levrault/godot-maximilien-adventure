extends Area2D
tool

export (String) var letter = 'M'


func _ready() -> void:
	self.connect('body_entered', self, '_on_Player_enter')
	$Letter/Label.text = letter
	$AnimationPlayer.play('Idle')
	$AnimationPlayer.connect('animation_finished', self, '_on_Chest_animation_finished')
	$Inputs.hide()
	
	if not ProjectSettings.get_setting('Debug/sound'):
		$AudioStreamPlayer.stream = null


#warning-ignore:unused_argument
func _process(delta) -> void:
	if Engine.editor_hint:
		$Letter/Label.text = letter


func _on_Player_enter(body: Player) -> void:
	if body is Player:
		body.can_open_chest = true
		body.chest_position = position
		$Inputs.show()
		InteractionsManager.connect('open_chest', self, '_on_Chest_open')


func _on_Chest_open() -> void:
	InteractionsManager.disconnect('open_chest', self, '_on_Chest_open')
	self.disconnect('body_entered', self, '_on_Player_enter')
	$Inputs.hide()
	GameManager.find_new_letter(letter)
	$AnimationPlayer.play('Open')


func _on_Chest_animation_finished(anim_name: String) -> void:
	if anim_name == 'Open':
		InteractionsManager.chest_opened()