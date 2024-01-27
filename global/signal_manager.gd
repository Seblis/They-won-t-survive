extends Node

signal on_player_attack_boost(enabled: bool)
signal on_boost_available_switch(available: bool)
signal on_ult_available_switch(available: bool)

signal on_score_updated(new_score: int)
signal on_player_health_updated(new_hp: int)
signal on_game_over(player_dead: bool)
