extends Node

const ALIMENT_SCENE: Resource = preload('res://collectibles/aliments/Aliment.tscn')

func drop_aliment(node: Node2D, position: Vector2) -> void:
	var aliment = ALIMENT_SCENE.instance()
	aliment.position = position
	node.call_deferred('add_child', aliment)