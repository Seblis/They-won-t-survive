extends Control

func apply_upgrade():
	GameEngine.get_player().get_node("HealthComponent").heal(10)
	SignalManager.on_upgrade_chosen.emit()
