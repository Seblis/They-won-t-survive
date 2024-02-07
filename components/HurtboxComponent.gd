class_name HurtboxComponent
extends Area2D

## Class responsible for detecting incoming projectiles and weapons
##
## Usage requires to add HealthComponent in the node inspector

@export var health: HealthComponent = null
@export var suppress_damage_display: bool = false
@export var invincibility_frames: int = 0
var _remaining_invincibility: int = 0
# we can add hit animation here

func _ready():
	global_position = get_parent().global_position

func _physics_process(_delta):
	if _remaining_invincibility:
		_remaining_invincibility -= 1
	else:
		set_deferred("monitoring", true)

func _on_body_entered(body):
	if body.is_in_group(GameEngine.GROUP_WEAPON):
		health.damage(body.get_damage())
		
		if invincibility_frames:
			_remaining_invincibility = invincibility_frames
			set_deferred("monitoring", false)
		# TODO: some collision effect?
		if body.is_in_group(GameEngine.GROUP_PROJECTILE):
			body.destroy()
