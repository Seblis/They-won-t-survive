extends Node

signal on_player_attack_boost(enabled: bool)
signal on_ability_used(on_cooldown: bool)
signal on_ultimate_used(available: bool)

signal on_score_updated(new_score: int)
signal on_player_health_updated(new_hp: int)
signal on_game_over(player_dead: bool)
