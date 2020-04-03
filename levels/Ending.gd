extends Node2D


func _ready() -> void:
	MusicManager.change_music("ending_1")


func return_to_menu() -> void:
	SceneManager.goto_scene("res://interfaces/menu/Menu.tscn")


func stop_music() -> void:
	MusicManager.stop()


func change_music_to_ending_2() -> void:
	MusicManager.change_music("ending_2")
