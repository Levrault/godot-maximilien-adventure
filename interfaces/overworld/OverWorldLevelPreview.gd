# Preview of a level
extends Control
class_name OverWorldLevelPreview

var scene_path := ""
var title := ""
var level := ""
var max_score := 0
var score := 0
var letters := {"M": false, "A": false, "X": false}
var music := ""


# Show/hide doth path
# @param {bool} left
# @param {bool} right
func display_dot(left: bool, right: bool) -> void:
	if not left:
		$LeftDor.hide()
	if not right:
		$RightDot.hide()


# @param {String} text
func set_title(text: String) -> void:
	$Title.text = text
	title = text


# @param {Resource} preview
func set_preview(preview: Texture) -> void:
	$Preview.texture = preview


# @param {Resource} orb
func set_orb(orb: Texture) -> void:
	$Orb.texture = orb
