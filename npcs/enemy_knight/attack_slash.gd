class_name KnightSlash
extends CharacterBody2D

@onready var animation_player = $AnimationPlayer

@export var _damage = 4
var _starting_position: Vector2
var _rage: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	global_position = _starting_position
	look_at(GameEngine.get_player_position())
	
	if _rage:
		animation_player.play("RageThrust")

func set_starting_position(pos: Vector2):
	_starting_position = pos

func _on_animation_finished(anim_name):
	queue_free()

func enrage():
	_rage = true

func get_damage():
	return _damage
