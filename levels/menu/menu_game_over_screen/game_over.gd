extends CanvasLayer

@onready var lbl_death = $VBoxContainer/Control/lblDeath
@onready var lbl_win = $VBoxContainer/Control/lblWin

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_game_over.connect(display)

func _process(_delta):
	if Input.is_action_just_pressed("ui_select"):
		get_tree().paused = false
		get_tree().change_scene_to_file("res://levels/menu/main.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func display(player_dead: bool):
	if player_dead:
		lbl_death.visible = true
	else:
		lbl_win.visible = true
	
	visible = true
