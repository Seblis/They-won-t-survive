extends Node2D

@export var key_texture:Texture2D
@onready var sprite_2d = $Sprite2D

func _ready():
	sprite_2d.texture = key_texture

