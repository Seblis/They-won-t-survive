extends Node2D

@export var _damage: int = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	var enemies = get_tree().get_nodes_in_group(GameEngine.GROUP_ENEMY)
	
	for enemy in enemies:
		for child in enemy.get_children():
			if child is HealthComponent:
				child.damage(_damage)


func _animation_finished(anim_name):
	queue_free()
