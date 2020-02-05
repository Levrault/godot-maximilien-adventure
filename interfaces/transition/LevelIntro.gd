extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	if GameManager.level_title != '':
		$LabelCharacterAnimated.text = GameManager.level_title
	else:
		$LabelCharacterAnimated.text = get_tree().get_current_scene().get_name()
	UiManager.connect("ui_intro_start", $LabelCharacterAnimated, "_on_Start")
	UiManager.connect("ui_intro_start", $AnimationPlayer, "play", ["Intro"])
	$LabelCharacterAnimated.connect("label_animation_finished", self, "_on_Finished")


func _on_Finished() -> void:
	$AnimationPlayer.play("FadeOut")
