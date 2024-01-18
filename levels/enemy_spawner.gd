extends Node

var spawn_counter = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_spawn_enemy.connect(_spawn_enemy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _spawn_enemy():
	#randomized spawn in future 
	print("Spawn counter: %d" %spawn_counter)
	var current_spawn_point
	if(spawn_counter < 4):
		self.get_child(spawn_counter).spawn()
	else:
		spawn_counter = 0
		self.get_child(spawn_counter).spawn()
	spawn_counter+=1


func _on_spawn_timer_timeout():
	_spawn_enemy()
