extends Node
## Class managing corrupted tiles - adds corruption etc.
##
## In order to add new weapon to the player, we need
## to add the weapon (which should be inherited from BaseWeapon)
## as a child of CorruptionWeapons node and then connect
## it's 

const CORRUPTION_LAYER: int = 1
enum TileType {STANDARD, CORRUPT, HOLY}
#@onready var _map: TileMap = $"../TileMap"

func _ready():
	SignalManager.on_new_corruption_weapon.connect(connect_corrupt)
	SignalManager.on_new_bless_weapon.connect(connect_bless)

func corrupt_tile(body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int):
	if body is TileMap:
		body.set_cell(TileType.CORRUPT, body.get_coords_for_body_rid(body_rid),
			CORRUPTION_LAYER, Vector2i(randi_range(0,3), randi_range(0,2)), 0)

func connect_corrupt(corrupt_attack: Area2D):
	corrupt_attack.body_shape_entered.connect(corrupt_tile)

func bless_tile(body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int):
	if body is TileMap:
		body.set_cell(TileType.HOLY, body.get_coords_for_body_rid(body_rid),
		CORRUPTION_LAYER, Vector2i(randi_range(0,3), randi_range(0,2)), 0)

func connect_bless(bless_attack: Area2D):
	bless_attack.body_shape_entered.connect(bless_tile)
