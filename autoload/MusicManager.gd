extends Node

const TRANSITION_DURATION := 0.4

var Music_player: AudioStreamPlayer = null
var Music_tween: Tween = null
var playlist := {
	"menu": "res://audio/music/Estimable.ogg",
	"overworld": "res://audio/music/Estimable.ogg",
	"chapter_1": "res://audio/music/Chiptronical.ogg",
	"chapter_2": "res://audio/music/Chiptronical.ogg",
	"chapter_3": "res://audio/music/Chiptronical.ogg",
	"chapter_4": "res://audio/music/Chiptronical.ogg",
	"chapter_5": "res://audio/music/Karibu Watu Wangu.ogg",
	"chapter_6": "res://audio/music/Karibu Watu Wangu.ogg",
	"chapter_7": "res://audio/music/Great Little Challenge.ogg",
	"boss_win": "res://audio/music/Las Dos Fronteras.ogg",
	"boss": "res://audio/music/Common Fight.ogg",
}
var current_music := ""


func _enter_tree() -> void:
	# Audio stream player
	Music_player = AudioStreamPlayer.new()
	Music_player.stream = load(playlist.menu)
	Music_player.volume_db = SettingsManager.VOLUME_MIN
	Music_player.bus = "Music"
	self.add_child(Music_player)
	Music_player.play()

	# Tween
	Music_tween = Tween.new()
	self.add_child(Music_tween)
	Music_tween.interpolate_property(
		Music_player,
		"volume_db",
		SettingsManager.VOLUME_MIN,
		SettingsManager.settings.music_volume,
		TRANSITION_DURATION,
		Tween.EASE_IN,
		0
	)
	Music_tween.start()


func change_music(new_music: String) -> void:
	if not playlist.has(new_music):
		Music_player.stop()
		return
	if current_music == playlist[new_music]:
		return
	Music_player.stop()
	current_music = playlist[new_music]
	Music_player.stream = load(current_music)
	Music_player.play()
	Music_tween.interpolate_property(
		Music_player,
		"volume_db",
		SettingsManager.VOLUME_MIN,
		SettingsManager.settings.music_volume,
		TRANSITION_DURATION,
		Tween.EASE_IN,
		0
	)
	Music_tween.start()


func set_volume_db(value: float) -> void:
	Music_player.volume_db = value


func play() -> void:
	Music_player.play()


func stop() -> void:
	print("stop")
	Music_player.stop()
