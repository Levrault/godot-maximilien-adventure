extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.connect("boss_death", self, "_on_Boss_death")
	$EnterBossRoomTrigger.connect("body_entered", self, "_on_Body_enter_boss")
	$FreeBossTrigger.connect("body_entered", self, "_on_Body_free_boss")


func _on_Body_enter_boss(body: Player) -> void:
	for explosion in $ExplosionEnter.get_children():
		explosion.show()
		explosion.start()
	owner.find_node("DestroyableTempleEnter").queue_free()
	$EnterBossRoomTrigger.queue_free()


func _on_Body_free_boss(body: Player) -> void:
	for explosion in $ExplosionEnterBoss.get_children():
		explosion.show()
		explosion.start()
	owner.find_node("DestroyableTempleBoss").queue_free()
	$FreeBossTrigger.queue_free()
	$AnimationPlayer.play("ActiveBoss")
	MusicManager.change_music("boss")

func _on_Boss_death() -> void:
	$Explosion.start()
	owner.find_node("DestroyableTempleExit").queue_free()
	MusicManager.change_music("boss_win")
	$CameraChangeZone.queue_free()
	$TweenCamera.interpolate_property(
		CameraManager.player_camera,
		"zoom",
		CameraManager.player_camera.zoom,
		Vector2(1, 1),
		0.5,
		Tween.EASE_IN,
		Tween.EASE_OUT
	)
	$TweenCamera.start()
