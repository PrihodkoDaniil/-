extends Node2D


func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://world.tscn")


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://MainMenu/settings_menu.tscn")


func _on_exit_pressed():
	get_tree().quit()
