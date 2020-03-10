# Manage meta
extends RichTextLabel


func _ready():
	self.connect("meta_clicked", self, "_on_Meta_clicked")


# @signal meta_clicked
func _on_Meta_clicked(meta: String) -> void:
	OS.shell_open(meta)
