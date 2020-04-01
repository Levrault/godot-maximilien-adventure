extends Node2D

var talked_to_sister := false
var talked_to_brother := false


func _ready():
	owner.get_node("World/NPCs/MargotBeatrice").connect("npc_talk", self, "_on_Npc_talk")
	owner.get_node("World/NPCs/Philemon").connect("npc_talk", self, "_on_Npc_talk")


func _on_Npc_talk(name: String) -> void:
	if name == "Margot-Béatrice":
		talked_to_sister = true
	if name == "Philémon":
		talked_to_brother = true

	if talked_to_sister and talked_to_brother:
		owner.get_node("World/NPCs/Luc").dialogue_lines[0] = "LVL10_LUC_YES"
		$Block.queue_free()
