extends TileMap
class_name Factory

var nodes:Array = []

func _ready() -> void:
	for tile in get_used_cells():
		var tile_name = get_tileset().tile_get_name(get_cellv(tile))
		var tile_path = "res://characters/enemies/"+tile_name+"/"+tile_name.capitalize()+".tscn"
		
		var node = load(tile_path).instance()
		nodes.append(node)
		node.global_position = map_to_world(tile) + _compute_position(node) + get_tileset().tile_get_texture_offset(get_cellv(tile))
		call_deferred("add_child", node)
	clear()


func _compute_position(node) -> Vector2:
	var size:Vector2 = node.get_node('Sprite').texture.get_size()
	var x:float = (size.x / node.get_node('Sprite').hframes) / 2
	var y:float = (size.y / node.get_node('Sprite').vframes) / 2
	return Vector2(x,y)