extends Sprite2D

@export var damage: int = 5
@export var SPEED: float = 250.0
var _target_vector: Vector2

func _ready():
	pass

func _physics_process(delta):
	global_position += _target_vector * SPEED * delta

func set_target(target: Node2D):
	_target_vector = (target.global_position - global_position).normalized()
	# TODO set rotation
