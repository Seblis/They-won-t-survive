extends Node2D

const fireball_scene: PackedScene = preload("res://player/weapons/fireball.tscn")

func _ready():
	global_position = get_parent().global_position

func _on_fireball_timer_timeout():
	var new_fireball = fireball_scene.instantiate()
	#new_fireball.global_position = global_position
	
	var direction = Vector2.ZERO
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	new_fireball.set_target_direction(direction)
	
	# TODO choose direction and rotation
	add_child(new_fireball)
	
func _physics_process(delta):
	pass
	#print("global/parent global")
	#print(str(global_position))
	#print(str(get_parent().global_position))
