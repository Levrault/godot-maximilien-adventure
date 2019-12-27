"""
Common getting hit script, use pushdown automate to return to previous state
"""
extends State
class_name GettingHit

onready var stream: Resource = load("res://sound/general-sounds/simple-damage-sounds/sfx_damage_hit5.wav")


func enter(host: Character) -> void:
	host.get_node("AnimationPlayer").play("GettingHit")
	print("%s has been hit" % [host.get_name()])
	play_sound(host, stream)
	host.snap_enable = false


func exit(host: Character) -> void:
	if host.is_alive:
		host.snap_enable = true
		host.can_attack = true


func _on_Animation_finished(anim_name: String, host: Character) -> void:
	assert anim_name == "GettingHit"
	if host.is_alive:
		emit_signal("finished", "Previous")
	else:
		emit_signal("finished", "Death")