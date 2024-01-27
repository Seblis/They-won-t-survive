extends CanvasLayer

@onready var lbl_death = $VBoxContainer/Control/lblDeath
@onready var lbl_win = $VBoxContainer/Control/lblWin

func _ready():
	SignalManager.on_game_over.connect(game_over)

func _process(_delta):
	if Input.is_action_just_pressed("ui_select"):
		get_tree().paused = false
		get_tree().change_scene_to_file("res://levels/menu/main.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func game_over(player_dead: bool):
	get_tree().paused = true
		
	if player_dead:
		lbl_death.visible = true
	else:
		lbl_win.visible = true
		
	visible = true
	
	HighScoreList.register_new_score()
	
