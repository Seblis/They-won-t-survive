extends TextureRect
const N: = preload("res://assets/sprites/N.png")
const Y = preload("res://assets/sprites/Y.png")
var sound = true

func _ready():
	texture = Y


func _input(ev):
	if Input.is_key_pressed(KEY_M):
		if sound:
			texture = N
		else:
			texture = Y
			
		sound = !sound
		AudioServer.set_bus_mute(0, not AudioServer.is_bus_mute(0))
