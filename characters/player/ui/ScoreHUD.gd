extends Control


func _on_Score_changed(score: int) -> void:
	$HBoxContainer/Score.text = '%s' % score
