extends Node

const GROUP_WEAPON = "GROUP_WEAPON"
const GROUP_PROJECTILE = "GROUP_PROJECTILE"
const GROUP_ENEMY = "GROUP_ENEMY"
const GROUP_PLAYER = "GROUP_PLAYER"

const C_SCORE_MULTIPLIER: int = 10
const B_SCORE_MULTIPLIER: int = -5
const K_SCORE_MULTIPLIER: int = 8
const SURVIVE_BONUS: int = 10000
const BUFFER_FRAMES: int = 3

@onready var game_win_timer = $GameWinTimer
@onready var difficulty_up_timer = $DifficultyUpTimer

var _weapon_direction: Vector2 = Vector2(1, 0)
var _last_diagonal: Vector2 = Vector2.ZERO
var _current_buffer: int = 0

var _blessed_area: int = 0
var _corrupted_area: int = 0
var _kill_amount: int = 0
var _game_win_bonus: int = 0

var _projectile_container: Node2D
var _enemy_container: Node2D
var _player: PlayerCharacter

func _physics_process(delta):
	if _current_buffer:
		_current_buffer -= 1

func _process(_delta):
	_set_weapon_direction()

#################### WEAPON SECTION ########################

func _set_weapon_direction():
	var new_x = Input.get_action_strength("Weapon right")\
		- Input.get_action_strength("Weapon left")
	var new_y = Input.get_action_strength("Weapon down")\
		- Input.get_action_strength("Weapon up")
	
	
	if new_x or new_y:
		if new_x and new_y:
			_last_diagonal.x = new_x
			_last_diagonal.y = new_y
			_current_buffer = BUFFER_FRAMES
			
		_weapon_direction.x = new_x
		_weapon_direction.y = new_y
	elif _current_buffer:
		_weapon_direction = _last_diagonal

func get_weapon_direction():
	return Vector2(_weapon_direction)

#################### SCORE SECTION ########################

func start_game():
	_kill_amount = 0
	_blessed_area = 0
	_corrupted_area = 0
	
	SignalManager.on_score_updated.emit(get_score())
	
	game_win_timer.start()
	difficulty_up_timer.start()
	
	get_tree().paused = false

func update_score(enemy_killed: bool):
	if enemy_killed:
		_kill_amount += 1
	else:
		_corrupted_area = CorruptionEngine.get_corrupted_area()
		_blessed_area = CorruptionEngine.get_blessed_area()

	SignalManager.on_score_updated.emit(get_score())

func get_score():
	var score: int = _game_win_bonus
	score += _kill_amount * K_SCORE_MULTIPLIER
	score += _blessed_area * B_SCORE_MULTIPLIER
	score += _corrupted_area * C_SCORE_MULTIPLIER
	
	return score

################# TIME SECTION ###############

func player_won():
	_game_win_bonus = SURVIVE_BONUS
	SignalManager.on_game_over.emit(false)

func game_time_left():
	return game_win_timer.time_left

################ ENTITY CONTAINERS ################

func set_enemy_container(enemy_container: Node2D):
	_enemy_container = enemy_container

func get_enemy_container():
	return _enemy_container

func add_enemy(enemy: Node2D):
	_enemy_container.add_child(enemy)
	
func set_projectile_container(projectile_container: Node2D):
	_projectile_container = projectile_container

func get_projectile_container():
	return _projectile_container

func add_projectile(enemy: Node2D):
	_projectile_container.add_child(enemy)

func set_player(player: PlayerCharacter):
	_player = player

func get_player():
	return _player

func get_player_position():
	if _player is PlayerCharacter:
		return _player.global_position
	else:
		return null
