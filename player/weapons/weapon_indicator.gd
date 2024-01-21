class_name WeaponIndicator
extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	look_at(global_position + GameEngine.get_weapon_direction())
