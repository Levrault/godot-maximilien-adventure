tool
extends EditorPlugin

var eds = null
var tilemaps := []


func _enter_tree() -> void:
	# Initialization of the plugin goes here
	eds = get_editor_interface().get_selection()
	eds.connect("selection_changed", self, "_on_selection_changed")
	find_tilemaps(get_node("/root"), Color(1, 1, 1, 1))


func _exit_tree() -> void:
	eds.disconnect("selection_changed", self, "_on_selection_changed")
	eds = null
	find_tilemaps(get_node("/root"), Color(1, 1, 1, 1))


func _on_selection_changed():
	# Returns an array of selected nodes
	var selected = eds.get_selected_nodes()

	# only if there is one tilemap selected
	if not selected.empty() and selected.size() == 1:
		var selected_node = selected[0]
		if selected_node is TileMap:
			find_tilemaps(get_node("/root"), Color(1, 0, 0, 1))
			selected_node.modulate = Color(1, 1, 1, 1)
		else:
			find_tilemaps(get_node("/root"), Color(1, 1, 1, 1))


func find_tilemaps(node, color) -> void:
	for child in node.get_children():
		if not child is TileMap:
			if child.get_child_count() > 0:
				find_tilemaps(child, color)
		else:
			child.modulate = color
