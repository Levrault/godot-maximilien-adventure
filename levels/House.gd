extends Node2D
class_name House


func _ready() -> void:
	$DetectPlayer.connect("body_entered", self, "_on_Player_enter")
	GameManager.set_max_score(GameManager.get_max_score() + $World/Collectibles/Gems.get_child_count())


func _on_Player_enter(body: Player) -> void:
	assert(body is Player)
	CameraManager.set_camera_limit($Bounds/Min.global_position, $Bounds/Max.global_position)
