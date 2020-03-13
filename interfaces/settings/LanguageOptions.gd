# Manage language settings
extends OptionButton

signal language_changed(language)

var language = 0 setget set_language

var languages_map := {
	0: {"language": "Français", "locale": "fr_CA"}, 1: {"language": "English", "locale": "en"}
}


func _ready():
	connect("item_selected", self, "_on_Language_selected")

	for key in languages_map:
		add_item(languages_map[key].language)


# Convert string language to id
# @param {String} new_language
func set_language(locale: String) -> void:
	for key in languages_map:
		if languages_map[key].locale == locale:
			selected = key
			return


# @signal item_selected
# @emit resolution_changed(resolution)
# @param {int} id
func _on_Language_selected(id: int) -> void:
	emit_signal("language_changed", {"id": id, "locale": languages_map[id].locale})
