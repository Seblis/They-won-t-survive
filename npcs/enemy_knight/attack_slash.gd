class_name KnightSlash
extends CharacterBody2D

@export var _damage = 4
var _starting_position: Vector2
var _target_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	global_position = _starting_position
	look_at(_target_position)

func set_starting_position(pos: Vector2):
	_starting_position = pos

func set_target_position(pos: Vector2):
	_target_position = pos

func _on_animation_finished(anim_name):
	queue_free()
	
func get_damage():
	return _damage
