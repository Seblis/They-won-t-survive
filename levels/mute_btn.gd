extends TextureRect

const MUTE_BUTTON_MUTED = preload("res://assets/sprites/Mute_button_muted.png")
const MUTE_BUTTON_UNMUTED = preload("res://assets/sprites/Mute_button_unmuted.png")
var sound = true

func _ready():
	texture = MUTE_BUTTON_UNMUTED


func _input(ev):
	if ev is InputEventKey and ev.pressed and ev.keycode == KEY_M:
		if sound:
			texture = MUTE_BUTTON_MUTED
		else:
			texture = MUTE_BUTTON_UNMUTED
			
		sound = !sound
		AudioServer.set_bus_mute(0, not AudioServer.is_bus_mute(0))
