extends Marker2D

@onready var player = $"../../Player"
const ENEMY_KNIGHT = preload("res://npcs/enemy_knight/enemy_knight.tscn")
const ENEMY_CLERIC = preload("res://npcs/enemy_cleric/enemy_cleric.tscn")
@onready var enemies = $"../../Enemies"
var enemy_randomizer = RandomNumberGenerator.new()

func spawn():
	var new_random_enemy = enemy_randomizer.randi_range(0, 4)
	var enemy_to_spawn
	if new_random_enemy == 4 :
		enemy_to_spawn = ENEMY_CLERIC.instantiate()
	else:
		enemy_to_spawn = ENEMY_KNIGHT.instantiate()
		enemy_to_spawn.set_player_node(player)
	
	enemy_to_spawn.global_position = self.global_position
	enemies.add_child(enemy_to_spawn)
