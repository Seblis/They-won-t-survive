class_name Fireball
extends CharacterBody2D

@export var damage: int = 5
@export var SPEED: float = 250.0
@onready var animation_player = $AnimationPlayer
@onready var collision_shape_2d = $CollisionShape2D

var _target_vector: Vector2

func _ready():
	global_position.x = get_parent().global_position.x
	global_position.y = get_parent().global_position.y

func _physics_process(delta):
	move_and_slide()

func set_target_node(target: Node2D):
	_target_vector = (target.global_position - global_position).normalized()
	# TODO set rotation
	
func set_target_direction(direction: Vector2):
	#_target_vector = direction.normalized()
	_target_vector = Vector2(1,1)
	look_at(global_position+_target_vector)
	velocity = _target_vector * SPEED

func _on_screen_exited():
	collision_shape_2d.disabled = true
	queue_free()
