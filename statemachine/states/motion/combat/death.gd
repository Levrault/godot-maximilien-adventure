# Common state to used with enemy and npc
extends State
class_name Death


func enter(host: Character) -> void:
	host.get_node("AnimationPlayer").play("Death")
	host.snap_enable = true
	host.velocity = Vector2(0, 0)


func _on_Animation_finished(anim_name: String, host: Character) -> void:
	assert(anim_name == "Death")
	assert(host is Character)
	host.queue_free()
