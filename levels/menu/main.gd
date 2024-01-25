extends Control

const SCORES_POPUP = preload("res://levels/scores_screen/high_score_table.tscn")

func _on_play_btn_pressed():
	get_tree().change_scene_to_file("res://levels/base_level.tscn")
	
	
func _on_quit_btn_pressed():
	get_tree().quit()


func _on_settings_btn_pressed():
	get_tree().change_scene_to_file("res://levels/settings/settings_scene.tscn")
	

func _input(event):
	if event is InputEventKey:
		if event.is_pressed() and event.keycode == KEY_S:
			var high_scores = SCORES_POPUP.instantiate()
			add_child(high_scores)
