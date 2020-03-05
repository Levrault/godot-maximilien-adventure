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
	$PrevBtn.connect("pressed", self, "_on_Prev_pressed")

	if SettingsManager.settings.empty():
		SettingsManager.init()
	settings = SettingsManager.settings

	assert(not settings.empty())

	# set values
	$Display/ResolutionOptions.resolution = settings.resolution
	$Display/FullscreenChk.pressed = settings.fullscreen
	$Display/LanguageOptions.language = settings.locale
	$Audio/MasterSlider.value = settings.master_volume
	$Audio/MusicSlider.value = settings.music_volume


"""
@param {String} resolution
"""
func _on_Resolution_selected(resolution: String) -> void:
	print("Resolution is : %s" % [resolution])
	settings.resolution = resolution


"""
@param {bool} button_pressed
"""
func _on_Fullscreen_check(button_pressed: bool) -> void:
	print("Fullscreen is : %s" % [button_pressed])
	settings.fullscreen = button_pressed


"""
@param {float} value
"""
func _on_Master_changed(value: float) -> void:
	print("Master is : %s" % [String(value)])
	settings.master_volume = value
	$AudioStreamPlayer.volume_db = value
	$Audio/MasterSlider/Timer.stop()
	$Audio/MasterSlider/Timer.start()


func _on_Master_timeout() -> void:
	if not play_master_sound:
		play_master_sound = true
		return
	$AudioStreamPlayer.play()


"""
@param {float} value
"""
func _on_Music_changed(value: float) -> void:
	print("Music is : %s" % [String(value)])
	settings.music_volume = value
	$AudioStreamPlayer.volume_db = value


"""
@param {Dictionary} language
"""
func _on_Language_selected(language: Dictionary) -> void:
	print("Language is : %s" % [language.locale])
	settings.locale = language.locale

	
func _on_Prev_pressed() -> void:
	print("reset data")


"""
Save data
"""
func _on_Save_pressed() -> void:
	print("in")
	$AnimationPlayer.play("Save")
	SettingsManager.save_settings(settings)
