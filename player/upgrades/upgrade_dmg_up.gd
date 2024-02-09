extends Control


func _apply_upgrade():
	# TODO
	SignalManager.on_upgrade_chosen.emit()
