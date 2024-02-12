extends Control

func _apply_upgrade():
	print("apply upgrade")
	GameEngine.get_player().get_node("HealthComponent").heal(10)
	SignalManager.on_upgrade_chosen.emit()
