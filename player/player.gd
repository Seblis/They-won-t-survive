extends CharacterBody2D

## Represents player character with it's collision shape, sprite and animation
##
## The class doesn't know about player's weapons - they are added in the game as
## a children of Player class and are shooting by themselves

const ULT_SKILL: PackedScene = preload("res://player/weapons/ultimate_skill.tscn")
const SPEED = 250.0

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D

enum State {RUN, DEATH}

var state: int
var _ult_available = true
var _boost_available = true

func _ready():
	state = State.RUN

func _physics_process(_delta):
	if state == State.RUN:
		update_run()

func _input(event):
	if state == State.RUN:
		if event.is_action_pressed("Attack boost"):
			_boost_available = false
			SignalManager.on_player_attack_boost.emit(true)
			SignalManager.on_boost_available_switch.emit(_boost_available)
			$BoostCooldown.start()
			get_viewport().set_input_as_handled()

		if _ult_available and event.is_action_pressed("Ultimate skill"):
			var ult = ULT_SKILL.instantiate()
			add_child(ult)
			_ult_available = false
			SignalManager.on_ult_available_switch.emit(_ult_available)
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


func _on_boost_cooldown_timeout():
	_boost_available = true
	SignalManager.on_boost_available_switch.emit(_boost_available)
