class_name Fireball
extends CharacterBody2D

const FIRE_DELAY: float = 0.15
const RECOIL_SPEED: float = 96.0
@export var damage: int = 5
@export var starting_speed: float = 350.0
@onready var animation_player = $AnimationPlayer
@onready var collision_shape_2d = $CollisionShape2D

var _speed: float
var _time_active: float
var _target_vector: Vector2
var _is_activated: bool
var _hit_target: bool = false
var _sfx_finished: bool = false

func _ready():
	_time_active = 0
	global_position = Vector2(GameEngine.get_player_position())
	_speed = starting_speed
	set_target_direction()

func _physics_process(delta):
	# Finish starting animation before moving fireball
	if _time_active < FIRE_DELAY:
		_time_active += delta
		
		var direction = Vector2.ZERO
		direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

		velocity = direction.normalized() * _speed
	else:
		velocity = _target_vector * _speed
		
	move_and_slide()

func set_target_direction():
	_target_vector = GameEngine.get_weapon_direction().normalized()
	look_at(global_position+_target_vector)

func _on_screen_exited():
	collision_shape_2d.disabled = true
	queue_free()
	
func get_damage():
	return damage
	
func destroy():
	animation_player.play("land")
	_speed = RECOIL_SPEED

func _on_animation_finished(anim_name = null):
	if anim_name == "land":
		if _sfx_finished:
			queue_free()
		else:
			_hit_target = true
			collision_shape_2d.set_deferred("disabled", true)

func _on_fireball_sound_finished():
	if _hit_target:
		queue_free()
	else:
		_sfx_finished = true
