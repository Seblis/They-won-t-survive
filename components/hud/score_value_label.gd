extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	var startingScore = 0
	text = str(startingScore)
	SignalManager.on_score_updated.connect(_update_score)
	
func _update_score(score:int):
	text = str(score)
	
