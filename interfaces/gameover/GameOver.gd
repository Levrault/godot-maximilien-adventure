extends Control

var input_listener := false

func _ready():
	visible = false
	UiManager.connect("ui_game_over_show", self, "_on_Show")


# Display with transition
func _on_Show() -> void:
	$AnimationPlayer.play("TransitionIn")
	PlayerManager.player.input_enable = false
	MusicManager.change_music("game_over")


# Active input listener
func active_input_listener() -> void:
	input_listener = true


func _input(event: InputEvent) -> void:
	if not input_listener:
		return
	if event.is_action_pressed("jump"):
		MusicManager.stop()
		SceneManager.goto_scene("res://interfaces/overworld/OverWorld.tscn")