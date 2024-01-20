extends Control


func _on_play_btn_pressed():
	get_tree().change_scene_to_file("res://levels/base_level.tscn")
	
	
func _on_quit_btn_pressed():
	get_tree().quit()


func _on_settings_btn_pressed():
	get_tree().change_scene_to_file("res://levels/settings/settings_scene.tscn")
