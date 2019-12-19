extends TileMap

var nodes:Array = []

func _ready() -> void:
	for tile in get_used_cells():
		var tile_name = get_tileset().tile_get_name(get_cellv(tile))
		var tile_path = "res://tiles/"+tile_name+".tscn"
		
		var directory = Directory.new();
		var doFileExists = directory.file_exists(tile_path)
		
		if doFileExists:
			var node = load(tile_path).instance()
			nodes.append(node)
			node.global_position = map_to_world(tile) + _compute_position(node) + get_tileset().tile_get_texture_offset(get_cellv(tile))
			call_deferred("add_child", node)


func _compute_position(node) -> Vector2:
	var size:Vector2 = node.texture.get_size()
	var x:float = (size.x / node.hframes) / 2
	var y:float = (size.y / node.vframes) / 2
	return Vector2(x,y)