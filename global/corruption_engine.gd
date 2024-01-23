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

func _ready():
	SignalManager.on_new_corruption_weapon.connect(connect_corrupt)
	SignalManager.on_new_bless_weapon.connect(connect_bless)

func reset_tiles(map):
	_map = map
	corrupted_tiles.clear()
	blessed_tiles.clear()

func corrupt_tile(body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int):
	if body is TileMap:
		var coords = body.get_coords_for_body_rid(body_rid)
		corrupted_tiles[body_rid] = null
		blessed_tiles.erase(body_rid)
		body.set_cell(TileType.CORRUPT, coords, CORRUPTION_LAYER,
			Vector2i(randi_range(0,3), randi_range(0,2)), 0)

func connect_corrupt(corrupt_attack: Area2D):
	corrupt_attack.body_shape_entered.connect(corrupt_tile)

func bless_tile(body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int):
	if body is TileMap:
		var coords = body.get_coords_for_body_rid(body_rid)
		blessed_tiles[body_rid] = null
		corrupted_tiles.erase(body_rid)
		body.set_cell(TileType.HOLY, coords, CORRUPTION_LAYER,
			Vector2i(randi_range(0,3), randi_range(0,2)), 0)

func connect_bless(bless_attack: Area2D):
	bless_attack.body_shape_entered.connect(bless_tile)

func rand_corrupted_tile_pos():
	if not corrupted_tiles:
		return null
	var size = corrupted_tiles.size()
	var random_rid = corrupted_tiles.keys()[randi() % size]
	print("Random key is ", random_rid)
	return _map.map_to_local(_map.get_coords_for_body_rid(random_rid))
	

