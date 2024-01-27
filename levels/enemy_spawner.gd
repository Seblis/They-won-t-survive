extends Node2D

var spawn_counter = 1

func _read():
	GameEngine.set_enemy_container(self)

func _spawn_enemy():
	# TODO: randomized spawn in future 
	var current_spawn_point
	if(spawn_counter < 4):
		self.get_child(spawn_counter).spawn()
	else:
		spawn_counter = 0
		self.get_child(spawn_counter).spawn()
	spawn_counter+=1


func _on_spawn_timer_timeout():
	_spawn_enemy()
