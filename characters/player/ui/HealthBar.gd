extends TextureRect


"""
update health value

@signal health_changed - Player.gd

@param {float} health_value
"""
func _on_Health_changed(health_value: float) -> void:
	$TextureProgress.update_value(health_value)