extends CharacterBody2D

const SPEED: float = 125.0
const DESIRED_RANGE: float = 128.0
const BLESS_SCENE = preload("res://npcs/enemy_cleric/attack_bless.tscn")
const WAIT_TIME: float = 6.0

enum State {WALK, BLESS, WAIT, DEATH}

var state: int = State.WALK
var _target_position
var _remaining_wait: float = 0


func _ready():
	_initiate_walk()

func _physics_process(delta):
	if state == State.WALK:
		_update_walk()
	elif state == State.BLESS:
		_update_bless()
	elif state == State.WAIT:
		_update_wait(delta)

func _initiate_walk():
	state = State.WALK
	# TODO: connect bless animation finished
	_target_position = CorruptionEngine.rand_corrupted_tile_pos()
	if _target_position == null:
		_initiate_wait()	

func _update_walk():
	var move_to_target = _target_position - global_position
	
	print("Len is ", move_to_target.length())
	if move_to_target.length() < DESIRED_RANGE:
		_initiate_bless()
		return
	
	move_to_target = move_to_target.normalized()
	velocity.x = move_to_target.x * SPEED
	velocity.y = move_to_target.y * SPEED
	
	#if velocity.x > 0:
		#sprite_2d.flip_h = false
	#elif velocity.x < 0:
		#sprite_2d.flip_h = true
		
	move_and_slide()

func _initiate_bless():
	state = State.BLESS
	# TODO: start playing bless animation, create bless attack and set its pos

func _update_bless():
	pass

func _initiate_wait():
	state = State.WAIT
	_remaining_wait = WAIT_TIME

func _update_wait(delta):
	_remaining_wait -= delta
	if _remaining_wait <= 0:
		_initiate_walk()

func _on_entity_died():
	state = State.DEATH
	# TODO: play death animation, queue free after animation is finished
	queue_free()
