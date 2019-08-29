extends Area2D
tool

export (String) var letter = 'M'
export (bool) var flip = false

var previous_flip: bool = !flip
var previous_letter: String = ''


func _ready() -> void:
	self.connect('body_entered', self, '_on_Player_enter')
	$Letter/Label.text = letter
	$AnimationPlayer.play('Idle')
	$AnimationPlayer.connect('animation_finished', self, '_on_Chest_animation_finished')
	$Inputs.hide()
	$Sprite.flip_h = flip
	if flip:
		$Sprite.position = Vector2(-7, -7)
	else:
		$Sprite.position = Vector2(10, -7)
	
	if not ProjectSettings.get_setting('Debug/sound'):
		$AudioStreamPlayer.stream = null


#warning-ignore:unused_argument
func _process(delta) -> void:
	if Engine.editor_hint:
		if previous_letter != letter:
			$Letter/Label.text = letter
			previous_letter = letter
		if flip != previous_flip:
			$Sprite.flip_h = flip
			previous_flip = flip
			if flip:
				$Sprite.position = Vector2(-7, -7)
			else:
				$Sprite.position = Vector2(10, -7)


func _on_Player_enter(body: Player) -> void:
	if body is Player:
		body.can_open_chest = true
		body.chest_position = position
		$Inputs.show()
		ChestManager.connect('active_chest', self, '_on_Chest_open')


func _on_Chest_open() -> void:
	ChestManager.disconnect('active_chest', self, '_on_Chest_open')
	self.disconnect('body_entered', self, '_on_Player_enter')
	$Inputs.hide()
	GameManager.find_new_letter(letter)
	$AnimationPlayer.play('Open')


func _on_Chest_animation_finished(anim_name: String) -> void:
	if anim_name == 'Open':
		ChestManager.inactive_chest()