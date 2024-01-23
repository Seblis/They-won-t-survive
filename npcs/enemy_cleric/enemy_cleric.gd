extends CharacterBody2D

const SPEED: float = 100.0
const DESIRED_RANGE: float = 128.0
const BLESS_SCENE = preload("res://npcs/enemy_cleric/attack_bless.tscn")
const WAIT_TIME: float = 2.0
const ATTACK_COOLDOWN: float = 1.0

enum State {WALK, BLESS, WAIT, DEATH}

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D
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
	animation_player.play("Run")
	_target_position = CorruptionEngine.rand_corrupted_tile_pos()
	if _target_position == null:
		_initiate_wait(WAIT_TIME)	

func _update_walk():
	var move_to_target = _target_position - global_position
	
	if move_to_target.length() < DESIRED_RANGE:
		_initiate_bless()
		return
	
	move_to_target = move_to_target.normalized()
	velocity.x = move_to_target.x * SPEED
	velocity.y = move_to_target.y * SPEED
	
	if velocity.x > 0:
		sprite_2d.flip_h = false
	elif velocity.x < 0:
		sprite_2d.flip_h = true
		
	move_and_slide()

func _initiate_bless():
	state = State.BLESS
	animation_player.play("Attack")
	var new_bless = BLESS_SCENE.instantiate()
	new_bless.set_target(_target_position)
	
	add_child(new_bless)

func _update_bless():
	pass

func _initiate_wait(time: float):
	state = State.WAIT
	_remaining_wait = time
	animation_player.play("Idle")

func _update_wait(delta):
	_remaining_wait -= delta
	if _remaining_wait <= 0:
		_initiate_walk()

func _on_entity_died():
	state = State.DEATH
	animation_player.play("Death")

func _on_animation_finished(anim_name):
	if anim_name == "Attack":
		_initiate_wait(ATTACK_COOLDOWN)
	elif anim_name == "Death":
		queue_free()
