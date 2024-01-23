extends Node2D

const fireball_scene: PackedScene = preload("res://player/weapons/fireball.tscn")
@onready var player: Node2D = $"../Player"
@onready var sounds = $Sounds



func _on_fireball_timer_timeout():
	var new_fireball = fireball_scene.instantiate()
	sounds.play()
	new_fireball.set_player_position(player.global_position)
	
	add_child(new_fireball)
