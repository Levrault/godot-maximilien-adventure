extends TextureRect


func _on_Health_changed(health_value: float) -> void:
	$TextureProgress.update_value(health_value)