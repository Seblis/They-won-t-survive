extends Marker2D

@onready var player = $"../../Player"
const ENEMY_KNIGHT = preload("res://npcs/enemy_knight/enemy_knight.tscn")
@onready var enemies = $"../../Enemies"

func spawn():
	var new_enemy = ENEMY_KNIGHT.instantiate()
	new_enemy.global_position = self.global_position
	new_enemy.set_player_node(player)
	enemies.add_child(new_enemy)
