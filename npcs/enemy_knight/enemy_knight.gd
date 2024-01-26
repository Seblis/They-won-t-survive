extends CharacterBody2D

const STARTING_SPEED: float = 150.0
const DIFFICULTY_MULTIPLIER: float = 1.2
const DESIRED_RANGE: float = 48.0
enum State {CHASE, ATTACK, DEATH}

static var slash_attack: PackedScene = preload("res://npcs/enemy_knight/attack_slash.tscn")
@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D

var player: Node2D
var state: int = State.CHASE
var _speed


func _ready():
	SignalManager.on_difficulty_up.connect(increase_speed)

func _physics_process(_delta):
	if state == State.CHASE:
		_process_chase()
	elif state == State.ATTACK:
		_process_attack()

func set_player_node(player_node):
	player = player_node

func _on_entity_died():
	state = State.DEATH
	velocity = Vector2.ZERO
	# animation player also shrinks 
	animation_player.play("Death")

func _on_animation_finished(anim_name):
	if anim_name == "Death":
		queue_free()
	elif anim_name == "Attack":
		_initiate_chase()
		
func _initiate_attack():
	state = State.ATTACK
	velocity = Vector2.ZERO
	animation_player.play("Attack")
	
	var slash: CharacterBody2D = slash_attack.instantiate()
	slash.set_starting_position(Vector2(global_position))
	slash.set_target_position(Vector2(player.global_position))
	
	add_child(slash)
	
	_process_attack()

func _process_attack():
	pass

func _initiate_chase():
	state = State.CHASE
	animation_player.play("Run")

func _process_chase():
	var move_to_player = player.global_position - global_position
	
	if move_to_player.length() < DESIRED_RANGE:
		_initiate_attack()
		return
	
	move_to_player = move_to_player.normalized()
	velocity.x = move_to_player.x * _speed
	velocity.y = move_to_player.y * _speed
	
	if velocity.x > 0:
		sprite_2d.flip_h = false
	elif velocity.x < 0:
		sprite_2d.flip_h = true
		
	move_and_slide()

func increase_speed():
	_speed *= DIFFICULTY_MULTIPLIER
