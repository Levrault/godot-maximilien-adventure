# Singleton that create and place healtpack
extends Node

const HEALTH_PACK_SCENE: Resource = preload("res://objects/items/HealthPack.tscn")


# Generate and add a new health pack to the map
# @param {Node2D} node
# @param {Vector2} position
func drop_health_pack(node: Node2D, position: Vector2) -> void:
	var health_pack = HEALTH_PACK_SCENE.instance()
	health_pack.position = position
	node.call_deferred("add_child", health_pack)
