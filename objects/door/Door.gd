# Door
extends Area2D


func _ready() -> void:
	self.connect("body_entered", self, "_on_Player_enter")
	self.connect("body_exited", self, "_on_Player_exited")
	$Inputs.hide()


# Let the player know that he can enter the door
# @signal body_entered
# @param {Player} body
func _on_Player_enter(body: Player) -> void:
	assert(body is Player)
	body.can_open_door = true
	$Inputs.show()
	DoorManager.connect("enter_door", self, "_on_Enter_door")


# Manage when player leave the door zone or is entering
# in the get in the contact with the exit door.
# @signal body_exited
# @param {Player} body
func _on_Player_exited(body: Player) -> void:
	assert(body is Player)
	if not body.is_entering_door:
		body.can_open_door = false
	$Inputs.hide()
	DoorManager.disconnect("enter_door", self, "_on_Enter_door")


# Teleporte player when interacting with the door
func _on_Enter_door() -> void:
	if has_node("House"):
		assert(get_node("House") is House)
		var house: House = get_node("House")
		DoorManager.set_previous_door_position(global_position)
		DoorManager.teleport(house.get_node("Spawn").get_global_position())
		CameraManager.transition_start("Curtain")
	else:
		CameraManager.reset_camera_limit()
		DoorManager.teleport(DoorManager.get_previous_door_position())
		CameraManager.transition_start("Curtain")
