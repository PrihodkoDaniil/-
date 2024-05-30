extends Node2D


func _on_new_game_pressed():
	load_game()


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://MainMenu/settings_menu.tscn")


func _on_exit_pressed():
	get_tree().quit()

func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		get_tree().change_scene_to_file("res://world.tscn")
	else:
		var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
		while save_game.get_position() < save_game.get_length():
			var json_string  = save_game.get_line()
			var json = JSON.new()
			var parse_result = json.parse(json_string)
			var node_data = json.get_data()
			var act = node_data["act"]
			get_tree().change_scene_to_file(act)
