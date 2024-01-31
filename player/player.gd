class_name PlayerCharacter
extends CharacterBody2D

## Represents player character with it's collision shape, sprite and animation
##
## The class doesn't know about player's weapons - they are added in the game as
## a children of Player class and are shooting by themselves

signal on_ability_pressed()
signal on_ult_pressed()

const ULT_SKILL: PackedScene = preload("res://player/weapons/ultimate_skill.tscn")
const SPEED = 250.0

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D

enum State {RUN, DEATH}

var state: int = State.RUN
var _ability: Callable = Callable(self, "attack_boost")
var _ultimate: Callable = Callable(self, "global_explosion")
var _ult_on_cooldown = false
var _ability_on_cooldown = false

func _ready():
	GameEngine.set_player(self)
	SignalManager.on_ability_used.connect(ability_cooldown_switch)
	SignalManager.on_ultimate_used.connect(ultimate_cooldown_switch)
	

func _physics_process(_delta):
	if state == State.RUN:
		update_run()

func _input(event):
	if state == State.RUN:
		if not _ability_on_cooldown and event.is_action_pressed("Basic ability"):
			# TODO: change input handling for abilities
			_ability.call()
			SignalManager.on_ability_used.emit(false)
			get_viewport().set_input_as_handled()

		if not _ult_on_cooldown and event.is_action_pressed("Ultimate ability"):
			_ultimate.call()
			SignalManager.on_ultimate_used.emit(false)
			get_viewport().set_input_as_handled()

func update_run():
	var direction = Vector2.ZERO
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	velocity = direction.normalized() * SPEED

	if direction.x or direction.y:
		animation_player.play("run")
		if direction.x < 0:
			sprite_2d.flip_h = true
		elif direction.x > 0:
			sprite_2d.flip_h = false
	else:
		animation_player.play("idle")
		
	move_and_slide()

func _on_player_death():
	state = State.DEATH
	animation_player.play("death")

func _on_player_death_animation_finished(anim_name):
	if anim_name == "death":
		SignalManager.on_game_over.emit(true)

####################################################

func ability_cooldown_switch(ability_used: bool):
	_ability_on_cooldown = not _ability_on_cooldown
	
func ultimate_cooldown_switch(ultimate_used: bool):
	_ult_on_cooldown = not _ult_on_cooldown

func add_weapon(weapon: Node2D):
	$PlayerWeapons.add_child(weapon)

################ STARTING WEAPONS #################

func attack_boost():
	SignalManager.on_player_attack_boost.emit()

func global_explosion():
	var ult = ULT_SKILL.instantiate()
	add_weapon(ult)
