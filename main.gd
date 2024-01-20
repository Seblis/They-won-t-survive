extends Control


func _on_btn_play_pressed():
	get_tree().change_scene_to_file("res://levels/base_level.tscn")


func _on_btn_quit_pressed():
	get_tree().quit()
