class_name HurtboxComponent
extends Area2D

## Class responsible for detecting incoming projectiles and weapons
##
## Usage requires to add HealthComponent in the node inspector

@export var health: HealthComponent = null
# we can add hit animation here

func _ready():
	global_position = get_parent().global_position

func _on_body_entered(body):
	if body.is_in_group(GameEngine.GROUP_PLAYER_WEAPON):
		health.damage(body.get_damage())
		# TODO: some collision effect?
		body.queue_free()
