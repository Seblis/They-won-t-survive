extends Control


func _apply_upgrade():
	Fireball.apply_bonus()
	SignalManager.on_upgrade_chosen.emit()
