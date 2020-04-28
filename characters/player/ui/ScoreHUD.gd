extends Control


func _ready() -> void:
	GameManager.connect("max_score_changed", self, "_on_Max_score_changed")
	GameManager.connect("score_changed", self, "_on_Score_changed")
	GameManager.connect("all_diamonds_found", $AnimationPlayer, "play", ["Success"])


# Total gems in the level
# @signal max_score_changed
# @param {int} max_score
func _on_Max_score_changed(max_score: int) -> void:
	$MaxScore.text = "%s" % max_score


# Current gems earn by the player
# @signal score_changed
# @param {int} max_score
func _on_Score_changed(score: int) -> void:
	$Score.text = "%s" % score
