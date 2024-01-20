extends CharacterBody2D

const SPEED: float = 150.0
const DESIRED_RANGE: float = 8.0
enum State {CHASE, ATTACK, DIE}

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D

var player: Node2D
var state: int = State.CHASE


func _ready():
	pass

func _physics_process(_delta):
	if state == State.CHASE:
		process_chase()
	elif state == State.ATTACK:
		process_attack()
	else:
		process_death()
	
	move_and_slide()

func set_player_node(player_node):
	player = player_node

func _on_entity_died():
	state = State.CHASE
	animation_player.play("Death")
	queue_free()

func process_attack():
	pass

func process_chase():
	var move_to_player = (player.global_position - global_position).normalized()
	velocity.x = move_to_player.x * SPEED
	velocity.y = move_to_player.y * SPEED
	
	if velocity.x > 0:
		sprite_2d.flip_h = false
	elif velocity.x < 0:
		sprite_2d.flip_h = true

func process_death():
	pass
