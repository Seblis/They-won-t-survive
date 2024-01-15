extends Node2D
@onready var _basic_corrupt = $BasicCorrupt
@onready var _map: TileMap = $"../../TileMap"

func _ready():
	_basic_corrupt.body_shape_entered.connect(corrupt_tile)

func corrupt_tile(_body_rid: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int):
	print(_map.get_coords_for_body_rid(_body_rid))
	#print(map.get_cell_source_id(1,map.get_coords_for_body_rid(_body_rid)))
	_map.set_cell(1, _map.get_coords_for_body_rid(_body_rid), 0, Vector2i(0, 0), 0)
	
func cleanse_tile(_body_rid: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int):
	_map.erase_cell(1, _map.get_coords_for_body_rid(_body_rid))
