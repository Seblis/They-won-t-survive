extends Area2D

@export var startup_frames: int = 0
@export var active_frames: int = 3
@export var cooldown: float = 4.0
@export var hitbox: Shape2D
@onready var attack_cooldown = $AttackCooldown
@onready var collision_shape_2d = $CollisionShape2D

var _active_left: int = -1
var _startup_left: int = -1
var _attack_enabled: bool = false

func _ready():
	attack_cooldown.wait_time = cooldown
	collision_shape_2d.shape = hitbox

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
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
