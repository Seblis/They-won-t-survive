extends Node
## Class managing corrupted tiles - adds corruption etc.
##
## In order to add new weapon to the player, we need
## to add the weapon (which should be inherited from BaseWeapon)
## as a child of CorruptionWeapons node and then connect
## it's 

const CORRUPTION_LAYER: int = 1
const C_SCORE_MULTIPLIER: int = 10
const B_SCORE_MULTIPLIER: int = -5
enum TileType {STANDARD, CORRUPT, HOLY}

var corrupted_tiles: Dictionary = {}
var blessed_tiles: Dictionary = {}
var _map: TileMap


func reset_tiles(map):
	_map = map
	corrupted_tiles.clear()
	blessed_tiles.clear()

func corrupt_tile(body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int):
	if body is TileMap:
		var coords = body.get_coords_for_body_rid(body_rid)
		corrupted_tiles[body_rid] = null
		blessed_tiles.erase(body_rid)
		body.set_cell(CORRUPTION_LAYER, coords, TileType.CORRUPT,
			Vector2i(randi_range(0,3), randi_range(0,2)), 0)

func bless_tile(body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int):
	if body is TileMap:
		var coords = body.get_coords_for_body_rid(body_rid)
		blessed_tiles[body_rid] = null
		corrupted_tiles.erase(body_rid)
		body.set_cell(CORRUPTION_LAYER, coords, TileType.HOLY,
			Vector2i(randi_range(0,3), randi_range(0,2)), 0)

func rand_corrupted_tile_pos():
	if not corrupted_tiles:
		return null
	var size = corrupted_tiles.size()
	var random_rid = corrupted_tiles.keys()[randi() % size]
	return _map.map_to_local(_map.get_coords_for_body_rid(random_rid))
	
func get_land_score():
	return corrupted_tiles.size() * C_SCORE_MULTIPLIER\
	+ blessed_tiles.size() * B_SCORE_MULTIPLIER

