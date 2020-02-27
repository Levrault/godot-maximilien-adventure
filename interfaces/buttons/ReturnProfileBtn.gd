"""

"""
extends TranslatedButton


func _ready():
	._ready()
	connect('pressed', self, '_on_Pressed')


"""
@signal pressed
"""
func _on_Pressed() -> void:
	var Menu := get_tree().get_root().get_node("Menu")
	Menu.get_node("AnimationPlayer").play("ProfileSelectedNo")
	Menu.get_node("Profiles/%s" % [Menu.selected_profile_node]).focus()
