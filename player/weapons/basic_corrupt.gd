extends Area2D

var _remaining_active_time: int = -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if _remaining_active_time > -1:
		_remaining_active_time -= 1

	if _remaining_active_time == -1:
		monitoring = false

func _on_attack_cooldown_timeout():
	_remaining_active_time = 3
	monitoring = true
