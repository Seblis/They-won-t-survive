extends CharacterBody2D

## Represents player character with it's collision shape, sprite and animation
##
## The class doesn't know about player's weapons - they are added in the game as
## a children of Player class and are shooting by themselves
const SPEED = 250.0

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D

enum State {RUN, DEATH}

var state: int

func _ready():
	state = State.RUN

func _physics_process(_delta):
	if state == State.RUN:
		update_run()
		

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
