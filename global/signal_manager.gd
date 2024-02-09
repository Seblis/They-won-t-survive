extends Node

signal on_ability_used(on_cooldown: bool)
signal on_ultimate_used(available: bool)

signal on_score_updated(new_score: int)
signal on_player_health_updated(new_hp: int, is_max_hp: bool)
signal on_game_over(player_dead: bool)

############### ABILITIES' SIGNALS ###############

signal on_upgrade_chosen()
signal on_player_attack_boost()
