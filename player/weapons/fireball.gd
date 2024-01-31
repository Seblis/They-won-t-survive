extends Node

const FIREBALL_SCENE: PackedScene = preload("res://player/weapons/fireball_projectile.tscn")
const STANDARD_COOLDOWN: float = 1.5
const BOOST_COOLDOWN: float = 0.75


func _ready():
	SignalManager.on_ability_used.connect(enable_boost)

func _fire_projectile():
	var new_fireball = FIREBALL_SCENE.instantiate()
	
	GameEngine.get_projectile_container().add_child(new_fireball)

func enable_boost(on_cooldown: bool):
	if not on_cooldown:
		$FireballTimer.wait_time = BOOST_COOLDOWN
		$FireballTimer.start()
		$BoostCooldown.start()
		$BoostTimer.start()
		
		_fire_projectile()


func _on_boost_timer_timeout():
	$FireballTimer.wait_time = STANDARD_COOLDOWN
