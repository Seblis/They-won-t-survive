extends Node2D
## For now the script is almost empty. Most likely some features will be
## managed here, but we'll see in the future

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("Quit"):
		get_tree().change_scene_to_file("res://main.tscn")
