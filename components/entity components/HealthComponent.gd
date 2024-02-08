class_name HealthComponent
extends Node2D

## Entity component managing its health
## 
## Class is responsible for taking damage, healing and notifying concerned
## parties that the entity's health dropped to zero. It's possible to add
## certain damage types, resistances etc. in this class in the future

signal on_entity_died

@export var max_health: int = 10
@export var hide_damage_label: bool = false
var _has_died: bool = false
var _current_health: int: set = set_current_health, get = get_current_health

func _ready():
	_current_health = max_health
	
func set_current_health(new_health: int):
	_current_health = clampi(new_health, 0, max_health)
	
	if get_parent().is_in_group(GameEngine.GROUP_PLAYER):
		SignalManager.on_player_health_updated.emit(_current_health)
		
	if not _current_health:
		_has_died = true
		on_entity_died.emit()
		if get_parent().is_in_group(GameEngine.GROUP_ENEMY):
			GameEngine.update_score(true)
	
func get_current_health():
	return _current_health
	
func damage(dmg_amount: int, force_hide_label: bool = false):
	_current_health -= dmg_amount
	if not hide_damage_label and not force_hide_label:
		DamageDisplay.display_number(dmg_amount, global_position)
	
func heal(heal_amount: int):
	damage(-heal_amount, true)
	
