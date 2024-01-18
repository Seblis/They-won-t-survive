class_name HurtboxComponent
extends Area2D

## Class responsible for detecting incoming projectiles and weapons
##
## Usage requires to add HealthComponent in the node inspector

@export var hurtbox_area: Array[CollisionShape2D] = []
@export var health: HealthComponent = null
# we can add hit animation here


func _on_body_entered(body):
	if body.is_in_group(GameEngine.GROUP_PROJECTILE):
		health.damage(body.get_damage())
		# TODO: some collision effect?
		body.queue_free()
