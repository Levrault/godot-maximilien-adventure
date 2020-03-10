# Manage resolution settings
extends OptionButton
signal resolution_changed(resolution)

var resolution = 3 setget set_resolution
var resolution_map := {
	0: "1920x1080", 1: "1366x768", 2: "800x600", 3: "960x540", 4: "640x480", 5: "480x270"
}


func _ready() -> void:
	connect("item_selected", self, "_on_Resolution_selected")
	for key in resolution_map:
		add_item(resolution_map[key])


# Convert string resolution to id
# @param {String} new_resolution
func set_resolution(new_resolution: String) -> void:
	for key in resolution_map:
		if resolution_map[key] == new_resolution:
			selected = key
			return


# @signal item_selected
# @emit resolution_changed(resolution)
# @param {int} id
func _on_Resolution_selected(id: int) -> void:
	emit_signal("resolution_changed", resolution_map[id])
