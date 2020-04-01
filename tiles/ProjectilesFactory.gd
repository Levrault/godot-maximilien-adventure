# Objectr pooling
static func instantiate(scene: Resource, global_position: Vector2, direction: float, node: Node):
	var projectile = scene.instance()
	projectile.position = global_position
	projectile.initialize(direction)
	node.add_child(projectile)
