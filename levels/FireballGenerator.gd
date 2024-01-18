extends Node2D

const fireball_scene: PackedScene = preload("res://player/weapons/fireball.tscn")
@onready var player = $"../Player"



func _on_fireball_timer_timeout():
	var new_fireball = fireball_scene.instantiate()
	new_fireball.set_player_position(player.global_position)
	
	add_child(new_fireball)
