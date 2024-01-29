extends Node2D

const ENEMY_KNIGHT = preload("res://npcs/enemy_knight/enemy_knight.tscn")
const ENEMY_CLERIC = preload("res://npcs/enemy_cleric/enemy_cleric.tscn")

@onready var enemy_spawn_location = $EnemySpawnLocation
var enemy_randomizer = RandomNumberGenerator.new()

func _read():
	GameEngine.set_enemy_container(self)

func spawn_enemy():
	var new_random_enemy = enemy_randomizer.randi_range(0, 4)
	var enemy_to_spawn
	
	if new_random_enemy == 4 :
		enemy_to_spawn = ENEMY_CLERIC.instantiate()
	else:
		enemy_to_spawn = ENEMY_KNIGHT.instantiate()
	
	enemy_spawn_location.progress_ratio = randf()
	
	enemy_to_spawn.global_position = enemy_spawn_location.global_position
	GameEngine.get_enemy_container().add_child(enemy_to_spawn)


func _on_spawn_timer_timeout():
	spawn_enemy()
