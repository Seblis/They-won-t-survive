extends CharacterBody2D

const DIFFICULTY_MULTIPLIER: float = 1.3
const MAX_RAGE: int = 3
enum State {CHASE, ATTACK, DEATH}

static var slash_attack: PackedScene = preload("res://npcs/enemy_knight/attack_slash.tscn")
@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D

var player: Node2D = GameEngine.get_player()
var state: int = State.CHASE
var _speed: float = 150.0
var _rage_level: int = 0
var _enraged: bool = false
var _desired_range: float = 48.0


func _physics_process(_delta):
	if state == State.CHASE:
		_process_chase()
	elif state == State.ATTACK:
		_process_attack()

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
	
	var slash: KnightSlash = slash_attack.instantiate()
	slash.set_starting_position(global_position)
	
	if _enraged:
		slash.enrage()
	
	add_child(slash)
	
	_process_attack()

func _process_attack():
	pass

func _initiate_chase():
	state = State.CHASE
	animation_player.play("Run")

func _process_chase():
	var move_to_player = player.global_position - global_position
	
	if move_to_player.length() < _desired_range:
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

func _on_speed_up():
	if _rage_level < MAX_RAGE:
		_rage_level += 1
		_speed *= DIFFICULTY_MULTIPLIER
		
		if _rage_level == MAX_RAGE:
			enter_rage()

func enter_rage():
	_enraged = true
	_desired_range *= 0.5
	$EnrageAnimation.play("Enrage")
