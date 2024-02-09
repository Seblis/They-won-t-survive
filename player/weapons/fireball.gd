extends Node

const FIREBALL_SCENE: PackedScene = preload("res://player/weapons/fireball_projectile.tscn")
var standard_cooldown: float = 1.5
const BOOST_MULTIPLICATOR: float = 0.5


func _ready():
	SignalManager.on_player_attack_boost.connect(enable_boost)

func _fire_projectile():
	var new_fireball = FIREBALL_SCENE.instantiate()
	
	GameEngine.get_projectile_container().add_child(new_fireball)

func enable_boost():
	$FireballTimer.wait_time = standard_cooldown * BOOST_MULTIPLICATOR
	$FireballTimer.start()
	$BoostCooldown.start()
	$BoostTimer.start()
	
	_fire_projectile()


func _on_boost_timer_timeout():
	$FireballTimer.wait_time = standard_cooldown

