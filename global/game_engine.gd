extends Node

const GROUP_WEAPON = "GROUP_WEAPON"
const GROUP_PROJECTILE = "GROUP_PROJECTILE"

const BUFFER_FRAMES: int = 3

var _weapon_direction: Vector2 = Vector2(1, 0)
var _last_diagonal: Vector2 = Vector2.ZERO
var _current_buffer: int = 0

func _physics_process(delta):
	if _current_buffer:
		_current_buffer -= 1

func _process(_delta):
	_set_weapon_direction()

func _set_weapon_direction():
	var new_x = Input.get_action_strength("Weapon right")\
		- Input.get_action_strength("Weapon left")
	var new_y = Input.get_action_strength("Weapon down")\
		- Input.get_action_strength("Weapon up")
	
	
	if new_x or new_y:
		if new_x and new_y:
			_last_diagonal.x = new_x
			_last_diagonal.y = new_y
			_current_buffer = BUFFER_FRAMES
			
		_weapon_direction.x = new_x
		_weapon_direction.y = new_y
	elif _current_buffer:
		_weapon_direction = _last_diagonal

func get_weapon_direction():
	return Vector2(_weapon_direction)
