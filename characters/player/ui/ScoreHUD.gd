extends Control

func _ready() -> void:
	GameManager.connect('max_score_changed', self, '_on_Max_score_changed')
	GameManager.connect('score_changed', self, '_on_Score_changed')


func _on_Max_score_changed(max_score: int) -> void:
	$VBoxContainer/MaxScore.text = '%s' % max_score


func _on_Score_changed(score: int) -> void:
	$VBoxContainer/Score.text = '%s' % score
