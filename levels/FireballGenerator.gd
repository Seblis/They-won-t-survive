extends Node2D

const fireball_scene: PackedScene = preload("res://player/weapons/fireball.tscn")
@onready var player = $"../Player"



func _on_fireball_timer_timeout():
	var new_fireball = fireball_scene.instantiate()
	#new_fireball.global_position = global_position
	
	var direction = Vector2.ZERO
	direction.x = Input.get_action_strength("Weapon right") - Input.get_action_strength("Weapon left")
	direction.y = Input.get_action_strength("Weapon down") - Input.get_action_strength("Weapon up")
	
	new_fireball.set_target_direction(direction)
	new_fireball.set_player_position(player.global_position)
	
	add_child(new_fireball)
