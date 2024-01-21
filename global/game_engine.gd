extends Node

const GROUP_WEAPON = "GROUP_WEAPON"
const GROUP_PROJECTILE = "GROUP_PROJECTILE"

var _weapon_direction: Vector2 = Vector2(1, 0)

func _process(_delta):
	_set_weapon_direction()

func _set_weapon_direction():
	var new_x = Input.get_action_strength("Weapon right") - Input.get_action_strength("Weapon left")
	var new_y = Input.get_action_strength("Weapon down") - Input.get_action_strength("Weapon up")
	
	if new_x or new_y:
		_weapon_direction.x = new_x
		_weapon_direction.y = new_y

func get_weapon_direction():
	return Vector2(_weapon_direction)
