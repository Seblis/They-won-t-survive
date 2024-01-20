class_name HitboxComponent
extends Area2D

@export var damage: int = 0
@export var hitbox_area: CollisionShape2D

func _ready():
	global_position = get_parent().global_position
