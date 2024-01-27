extends Node

const FIREBALL_SCENE: PackedScene = preload("res://player/weapons/fireball_projectile.tscn")

func _on_fireball_timer_timeout():
	var new_fireball = FIREBALL_SCENE.instantiate()
	
	GameEngine.get_projectile_container().add_child(new_fireball)
