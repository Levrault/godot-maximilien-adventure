# Lost a life screen manager
extends Control

const TIPS_PREFIX := "UI_TIPS_"
const MAX_TIPS := 9

var rng = RandomNumberGenerator.new()


func _ready():
	UiManager.connect("ui_loose_life_show", self, "_on_Show")


# Generate and translate tips
func _generate_tips() -> void:
	rng.randomize()
	var id: int = rng.randi_range(0, MAX_TIPS)
	$PanelContainer/VBoxContainer/TipsText.text = TranslationServer.translate(TIPS_PREFIX + str(id))


# Display with transition
func _on_Show() -> void:
	_generate_tips()
	$AnimationPlayer.play("TransitionIn")
	show()


# Update life indicator
func _remove_life() -> void:
	var ChildAnimationPlayer := $LifeIndicator.get_child($LifeIndicator.get_child_count() - 1).get_node(
		"AnimationPlayer"
	)
	ChildAnimationPlayer.connect("animation_finished", self, "_on_Life_animation_finish")
	ChildAnimationPlayer.play("FadeOut")


# Replace player to the last valid position
# @emit player_life(player_life)
# @emit player_retry_checkpoint
func reset_player() -> void:
	GameManager.player_loose_life()
	PlayerManager.retry_checkpoint()


# Close ui
# @emit ui_loose_life_hide
# @emit player_input_enable
func _close() -> void:
	PlayerManager.input_enable()
	UiManager.hide_lost_a_life_screen()
	hide()


# @signal animation_finised
# @param {String} anim_name
func _on_Life_animation_finish(anim_name: String) -> void:
	assert(anim_name == "FadeOut")
	$AnimationPlayer.play("TransitionOut")
