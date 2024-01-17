extends Node
## Class managing corrupted tiles - adds corruption etc.
##
## In order to add new weapon to the player, we need
## to add the weapon (which should be inherited from BaseWeapon)
## as a child of CorruptionWeapons node and then connect
## it's 


@onready var corruption_weapons = $"../Player/CorruptionWeapons"
@onready var _map: TileMap = $"../TileMap"

func _ready():
	# TODO connection needs to be updated when player changes weapons
	for child in corruption_weapons.get_children():
		child.body_shape_entered.connect(corrupt_tile)

func corrupt_tile(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int):
	if body is TileMap:
		_map.set_cell(1, _map.get_coords_for_body_rid(_body_rid),
			1, Vector2i(randi_range(0,3), randi_range(0,2)), 0)
	
func cleanse_tile(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int):
	if body is TileMap:
		_map.erase_cell(1, _map.get_coords_for_body_rid(_body_rid))
