extends Node


const TRANSITION_DURATION := 0.4

var Music_player: AudioStreamPlayer = null
var Music_tween: Tween = null
var musics := {
	"menu": "res://audio/music/Estimable.ogg",
	"chiptronical": "res://audio/music/Chiptronical.ogg"
}
var current_music := ''


func _enter_tree()-> void:
	# Audio stream player
	Music_player = AudioStreamPlayer.new()
	Music_player.stream = load(musics.menu)
	Music_player.volume_db = SettingsManager.VOLUME_MIN
	Music_player.bus = "Music"
	self.add_child(Music_player)
	Music_player.play()

	# Tween
	Music_tween = Tween.new()
	self.add_child(Music_tween)
	Music_tween.interpolate_property(Music_player, "volume_db", SettingsManager.VOLUME_MIN, SettingsManager.settings.music_volume, TRANSITION_DURATION, Tween.EASE_IN, 0)
	Music_tween.start()


func change_music(new_music: String) -> void:
	if not musics.has(new_music) or current_music == new_music:
		return
	Music_player.stop()
	current_music = new_music
	Music_player.stream = load(musics[new_music])
	Music_player.play()
	Music_tween.interpolate_property(Music_player, "volume_db", SettingsManager.VOLUME_MIN, SettingsManager.settings.music_volume, TRANSITION_DURATION, Tween.EASE_IN, 0)
	Music_tween.start()


func set_volume_db(value: float) -> void:
	Music_player.volume_db = value


func play() -> void:
	Music_player.play()


func stop() -> void:
	Music_player.stop()

