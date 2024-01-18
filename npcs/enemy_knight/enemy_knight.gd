extends CharacterBody2D

const SPEED = 150.0
var player


func _ready():
	pass

func _physics_process(delta):
	var move_to_player = (player.global_position - global_position).normalized()
	velocity.x = move_to_player.x * SPEED
	velocity.y = move_to_player.y * SPEED
	
	move_and_slide()

func set_player_node(player_node):
	player = player_node
	

func _on_entity_died():
	queue_free()
