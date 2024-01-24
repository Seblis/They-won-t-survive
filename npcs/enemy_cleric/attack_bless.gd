class_name Bless
extends Area2D

var _target_tile: Vector2

func _ready():
	self.body_shape_entered.connect(CorruptionEngine.bless_tile)
	global_position = _target_tile

func set_target(target: Vector2):
	_target_tile = target

func _animation_finished(anim_name):
	GameEngine.update_score(false)
	queue_free()
