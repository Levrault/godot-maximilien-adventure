extends Label
signal label_animation_finished


func _ready() -> void:
	$Timer.connect("timeout", self, "_on_Animated_line")
	$Delay.connect("timeout", self, "_on_Delay_start")
	visible_characters = 0


# Start and wait
# @signal ui_intro_start - LevelIntro
func _on_Start(delay: float = 1.0) -> void:
	$Delay.wait_time = delay
	$Delay.start()


# Start timer
# @signal timeout
func _on_Delay_start() -> void:
	$Timer.start()


# Will display each character of the sentence with a little animation.
# manage when the dialogue is completed or 
# need to wait for the player to display the next sentence
# @signal timeout
# @emit dialogue_text_completed
func _on_Animated_line() -> void:
	if not visible_characters == text.length():
		visible_characters += 1
	else:
		emit_signal("label_animation_finished")
