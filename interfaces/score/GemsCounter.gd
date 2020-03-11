# One many gems does Max a found in this level
extends Control
class_name GemsCounter

var counter := 0


func _ready():
	$Timer.connect("timeout", self, "_on_Score_update")
	GameManager.connect("max_score_changed", self, "_on_Max_score_update")


# Update counter till it hit max's score
# @signal timeout - $Timer
func _on_Score_update() -> void:
	if counter < GameManager.get_score():
		counter += 1
		$Score.text = "%s" % counter
		$AudioStreamPlayer.play()
	else:
		$Timer.stop()


# Set Max score
# @signal max_score_changed - gamemanager
# @param {int} max_score
func _on_Max_score_update(max_score: int) -> void:
	$Max.text = "%s" % max_score
