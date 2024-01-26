extends Label

@onready var gameLeftTimer:Timer = $"../../GameWinTimer"

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = _format_seconds(gameLeftTimer.time_left)
	
	
func _format_seconds(time : float) -> String:
	var minutes := time / 60
	var seconds := fmod(time, 60)
	return "%02d:%02d" % [minutes, seconds]
