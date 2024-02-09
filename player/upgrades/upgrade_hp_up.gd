extends Control

func _apply_upgrade():
	GameEngine.get_player().get_node("HealthComponent").modify_max_hp(5)
	SignalManager.on_upgrade_chosen.emit()
