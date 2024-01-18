class_name Fireball
extends CharacterBody2D

const FIRE_DELAY: float = 0.15
@export var damage: int = 5
@export var SPEED: float = 300.0
@onready var animation_player = $AnimationPlayer
@onready var collision_shape_2d = $CollisionShape2D

var _time_active: float
var _target_vector: Vector2
var _is_activated: bool
var _player_position: Vector2

func _ready():
	_time_active = 0
	_is_activated = false
	global_position = _player_position

func _physics_process(delta):
	# Finish starting animation before moving fireball
	if _time_active < FIRE_DELAY:
		_time_active += delta
		
		var direction = Vector2.ZERO
		direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

		velocity = direction.normalized() * SPEED
	else:
		velocity = _target_vector * SPEED
		
	move_and_slide()

func set_target_direction(direction: Vector2):
	_target_vector = direction.normalized()
	look_at(global_position+_target_vector)

func set_player_position(pos: Vector2):
	_player_position = Vector2(pos)

func _on_screen_exited():
	collision_shape_2d.disabled = true
	queue_free()
