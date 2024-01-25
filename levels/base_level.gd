extends Node2D
## For now the script is almost empty. Most likely some features will be
## managed here, but we'll see in the future

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_game_over.connect(game_over)
	GameEngine.reset_score()
	get_tree().paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("Quit"):
		get_tree().change_scene_to_file("res://levels/menu/main.tscn")

func game_over(player_dead: bool):
	get_tree().paused = true
	var scores_list: HighScoreList = HighScoreList.load_highscores()
	scores_list.register_new_score(GameEngine.get_score())
	
