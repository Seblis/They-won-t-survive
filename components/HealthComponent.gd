class_name HealthComponent
extends Node

## Entity component managing its health
## 
## Class is responsible for taking damage, healing and notifying concerned
## parties that the entity's health dropped to zero. It's possible to add
## certain damage types, resistances etc. in this class in the future



signal on_entity_died

@export var MAX_HEALTH: int = 10
@export var HIDE_DAMAGE_LABEL: bool = false
var _has_died: bool = false
var _current_health: int: set = set_current_health, get = get_current_health

func _ready():
	_current_health = MAX_HEALTH
	
func set_current_health(new_health: int):
	_current_health = clampi(new_health, 0, MAX_HEALTH)
	if not _current_health:
		_has_died = true
		on_entity_died.emit()
	
func get_current_health():
	return _current_health
	
func damage(dmg_amount: int, hide_damage_label: bool = false):
	_current_health = set_current_health(_current_health - dmg_amount)
	# TODO show damage label near the enemy if the second parameter is false
	
func heal(heal_amount: int):
	damage(-heal_amount, true)
	
