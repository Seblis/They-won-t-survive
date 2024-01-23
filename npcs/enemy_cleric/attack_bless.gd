class_name Bless
extends Area2D

var _target_tile: Vector2

func _ready():
	global_position = _target_tile

func set_target(target: Vector2):
	_target_tile = target


func _animation_finished(anim_name):
	queue_free()
