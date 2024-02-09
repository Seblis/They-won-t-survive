extends Control

@export var upg_hp_up: PackedScene = preload("res://player/upgrades/upgrade_hp_up.tscn")
@export var upg_dmg_up: PackedScene = preload("res://player/upgrades/upgrade_dmg_up.tscn")
@export var upg_heal: PackedScene = preload("res://player/upgrades/upgrade_heal.tscn")
var upgrades_list: Array[PackedScene] = []	
@onready var upgrades_container = $MarginContainer/VBoxContainer/UpgradesContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	SignalManager.on_upgrade_chosen.connect(_resume)
	
	upgrades_list = [upg_hp_up, upg_dmg_up, upg_heal]
	for upgrade in upgrades_list:
		upgrades_container.add_child(upgrade.instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _resume():
	get_tree().paused = false
	queue_free()
