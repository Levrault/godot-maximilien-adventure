extends Motion
class_name SlimeOnGround


func enter(host: Slime) -> void:
	$DetectPlayer.connect("body_entered", self, "_on_Player_entered", [host])
	$BouncingZoneBoss.set_collision_mask_bit(1, true)
	$DetectPlayer.set_deferred("monitoring", true)


func exit(host: Slime) -> void:
	$DetectPlayer.disconnect("body_entered", self, "_on_Player_entered")
	$BouncingZoneBoss.set_collision_mask_bit(1, false)
	$DetectPlayer.set_deferred("monitoring", false)
