extends Control

const SCORES_POPUP = preload("res://levels/scores_screen/high_score_table.tscn")

func _on_play_btn_pressed():
	get_tree().change_scene_to_file("res://levels/base_level.tscn")
	
	
func _on_quit_btn_pressed():
	get_tree().quit()


func _on_settings_btn_pressed():
	get_tree().change_scene_to_file("res://levels/settings/settings_scene.tscn")
	

func _on_high_scores_button_pressed():
	add_child(SCORES_POPUP.instantiate())
