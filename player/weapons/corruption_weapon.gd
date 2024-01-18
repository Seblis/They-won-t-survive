extends Area2D

## Base class for every weapons changing tiles to corrupted ones.
##
## Most properties are set by hand in the Inspector or prepare in _ready().
## Instances of corruption weapons should be added during the game
## as children of the dedicated Node2D called CorruptionWeapons

@export var startup_frames: int = 0
@export var active_frames: int = 3
@export var cooldown: float = 4.0
@export var hitbox: Shape2D
@onready var attack_cooldown = $AttackCooldown
@onready var collision_shape_2d = $CollisionShape2D
@onready var animated_sprite_2d = $AnimatedSprite2D

var _active_left: int = -1
var _startup_left: int = -1
var _attack_enabled: bool = false

func _ready():
	attack_cooldown.wait_time = cooldown
	collision_shape_2d.shape = hitbox
	collision_shape_2d.global_position = get_parent().global_position
	animated_sprite_2d.global_position = get_parent().global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if _attack_enabled:
		if _startup_left:
			_startup_left -= 1
			return
		else:
			monitoring = true
		
		if _active_left:
			_active_left -= 1
		else:
			_attack_enabled = false
			monitoring = false
		
		

func _on_attack_cooldown_timeout():
	_active_left = active_frames
	_startup_left = startup_frames
	_attack_enabled = true
	animated_sprite_2d.play("default")
