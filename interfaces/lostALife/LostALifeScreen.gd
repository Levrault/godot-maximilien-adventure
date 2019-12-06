extends Control

const TIPS_PREFIX = 'TIPS_'
const MAX_TIPS = 2

var rng = RandomNumberGenerator.new()

func _ready():
	UiManager.connect('ui_loose_life_show', self, '_on_Show')
	$Timer.connect('timeout', self, '_on_Timeout')
	_generate_tips()


func _generate_tips() -> void:
	rng.randomize()
	var id:int = rng.randi_range(0, MAX_TIPS)
	$PanelContainer/VBoxContainer/TipsText.text = TranslationServer.translate(TIPS_PREFIX + str(id))


func _on_Show() -> void:
	$Timer.start()
	show()


func _on_Timeout() -> void:
	var child = $LifeIndicator.get_child($LifeIndicator.get_child_count()-1)
	child.get_node('AnimationPlayer').connect('animation_finished', self, '_hide')
	child.get_node('AnimationPlayer').play('FadeOut')
	$LifeIndicator.get_child($LifeIndicator.get_child_count()-1).get_node('AnimationPlayer').play('FadeOut')
	$Timer.stop()


func _hide(anim_name: String) -> void:
	assert anim_name == 'FadeOut'
	hide()
	GameManager.player_loose_life()