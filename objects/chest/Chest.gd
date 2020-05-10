# Chest contains hidden letter (M-A-X) and are use has hidden object
# in the level.
tool
extends Area2D

export (String) var letter := "M"
export (bool) var flip := false

var previous_flip := true
var previous_letter := ""


func _ready() -> void:
	connect("body_entered", self, "_on_Player_enter")
	connect("body_exited", self, "_on_Player_exited")

	$Letter/Label.text = letter
	$AnimationPlayer.play("Idle")
	$Sprite.flip_h = flip

	# when flipped
	if flip:
		$Sprite.position = Vector2(-7, -7)
	else:
		$Sprite.position = Vector2(10, -7)

	# debug
	if not Engine.editor_hint:
		$Inputs.hide()


# Live switching
func _process(delta) -> void:
	if Engine.editor_hint:
		if previous_letter != letter:
			$Inputs.show()
			$Letter/Label.text = letter
			previous_letter = letter
		if flip != previous_flip:
			$Inputs.show()
			$Sprite.flip_h = flip
			previous_flip = flip
			if flip:
				$Sprite.position = Vector2(-7, -7)
			else:
				$Sprite.position = Vector2(10, -7)


# @signal body_entered
func _on_Player_enter(body: Player) -> void:
	assert(body is Player)
	print("Player can open %s" % [get_name()])
	body.can_open_chest = true
	body.chest_position = position
	$Inputs.show()

	ChestManager.connect("active_chest", self, "_on_Chest_open")


# @signal body_exited
func _on_Player_exited(body: Player) -> void:
	assert(body is Player)
	print("Player exited %s's interaction zone" % [get_name()])
	$Inputs.hide()

	ChestManager.disconnect("active_chest", self, "_on_Chest_open")


# @signal active_chest
# @emit letter_found(letter)
func _on_Chest_open() -> void:
	print("Player has opened %s and found %s" % [get_name(), letter])
	$Inputs.hide()
	GameManager.find_new_letter(letter)
	$AnimationPlayer.play("Open")

	ChestManager.disconnect("active_chest", self, "_on_Chest_open")
	disconnect("body_entered", self, "_on_Player_enter")
	disconnect("body_exited", self, "_on_Player_exited")


# Call from animation player
# @signal inactive_chect 
func inactive_chest() -> void:
	print("Player should change state after opening %s" % [get_name()])
	ChestManager.inactive_chest()