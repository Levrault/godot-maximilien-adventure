extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$LabelCharacterAnimated.text = TranslationServer.translate(
		get_tree().get_root().get_node("Game").level_title_fallback
	)
	UiManager.connect("ui_intro_start", $LabelCharacterAnimated, "_on_Start")
	UiManager.connect("ui_intro_start", $AnimationPlayer, "play", ["Intro"])
	UiManager.connect("ui_intro_hide", self, "hide")
	UiManager.connect("ui_intro_show", self, "show")
	$LabelCharacterAnimated.connect("label_animation_finished", self, "_on_Finished")


func _on_Finished() -> void:
	$AnimationPlayer.play("FadeOut")
