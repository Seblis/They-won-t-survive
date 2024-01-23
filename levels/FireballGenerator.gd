extends Node2D

const FIREBALL_SCENE: PackedScene = preload("res://player/weapons/fireball.tscn")
@onready var player: Node2D = $"../Player"


func _on_fireball_timer_timeout():
	var new_fireball = FIREBALL_SCENE.instantiate()
	new_fireball.set_player_position(player.global_position)
	
	add_child(new_fireball)
