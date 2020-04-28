# slime boss script
# * Trigger monster sound
# * Start music
# * Open passage on monster death
extends Node2D


func _ready():
	GameManager.connect("boss_death", self, "_on_Boss_death")
	$MusicTrigger.connect("body_entered", self, "_on_Music_trigger")
	$CryTrigger.connect("body_entered", self, "_on_Cry_trigger")
	$WinMusicTrigger.connect("body_entered", self, "_on_Win_trigger")

	MusicManager.stop()


func _on_Boss_death() -> void:
	$AnimationPlayer.play("WallExplosion")


# Call on animationplayer
func destroy_wall() -> void:
	owner.find_node("DestroyableJungleGrayCollider").queue_free()
	MusicManager.stop()


# @signal body_entered
func _on_Music_trigger(body: Player) -> void:
	MusicManager.change_music("boss")


# @signal body_entered
func _on_Win_trigger(body: Player) -> void:
	MusicManager.change_music("boss_win")


# @signal body_entered
func _on_Cry_trigger(body: Player) -> void:
	$AudioStreamPlayer.play()
	$CryTrigger.queue_free()
