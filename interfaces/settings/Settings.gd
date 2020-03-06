"""
Manage settings options
"""
extends Control

var settings := {}
var play_master_sound := false


func _ready():
	$AnimationPlayer.play("Setup")
	# Display
	$Display/ResolutionOptions.connect("resolution_changed", self, "_on_Resolution_selected")
	$Display/FullscreenChk.connect("toggled", self, "_on_Fullscreen_check")
	$Display/LanguageOptions.connect("language_changed", self, "_on_Language_selected")

	# Audio
	$Audio/MasterSlider.connect("value_changed", self, "_on_Master_changed")
	$Audio/MasterSlider/Timer.connect("timeout", self, "_on_Master_timeout")
	$Audio/MusicSlider.connect("value_changed", self, "_on_Music_changed")

	# Save
	$SaveBtn.connect("pressed", self, "_on_Save_pressed")
	$PrevSettingsButton.connect("pressed", self, "_on_Prev_pressed")

	settings = SettingsManager.settings.duplicate(true)

	assert(not settings.empty())

	# set values
	$Display/ResolutionOptions.resolution = settings.resolution
	$Display/FullscreenChk.pressed = settings.fullscreen
	$Display/LanguageOptions.language = settings.locale
	$Audio/MasterSlider.value = settings.master_volume
	$Audio/MusicSlider.value = settings.music_volume


"""
@param {String} resolution
@signal resolution changed
"""
func _on_Resolution_selected(resolution: String) -> void:
	print("Resolution is : %s" % [resolution])
	settings.resolution = resolution


"""
@param {bool} button_pressed
@signal toggled
"""
func _on_Fullscreen_check(button_pressed: bool) -> void:
	print("Fullscreen is : %s" % [button_pressed])
	settings.fullscreen = button_pressed


"""
@param {float} value
@signal value_changed
"""
func _on_Master_changed(value: float) -> void:
	print("Master is : %s" % [String(value)])
	settings.master_volume = value
	$AudioStreamPlayer.volume_db = value
	$Audio/MasterSlider/Timer.stop()
	$Audio/MasterSlider/Timer.start()


"""
Play audio stream if player stop using slider
@signal timeout
"""
func _on_Master_timeout() -> void:
	if not play_master_sound:
		play_master_sound = true
		return
	$AudioStreamPlayer.play()


"""
@param {float} value
@signal value_changed
"""
func _on_Music_changed(value: float) -> void:
	print("Music is : %s" % [String(value)])
	settings.music_volume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), settings.music_volume)


"""
@param {Dictionary} language
"""
func _on_Language_selected(language: Dictionary) -> void:
	print("Language is : %s" % [language.locale])
	settings.locale = language.locale

	
func _on_Prev_pressed() -> void:
	print(SettingsManager.settings)
	SettingsManager.save_settings(SettingsManager.settings)
	queue_free()
	get_tree().change_scene("res://interfaces/menu/Menu.tscn")


"""
Save data
"""
func _on_Save_pressed() -> void:
	$AnimationPlayer.play("Save")
	SettingsManager.save_settings(settings)
