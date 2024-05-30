extends Node2D

var position_dic = {}

@onready var player = $PlayerBody

func _ready():
	load_game()

func _input(event):
	if Input.is_action_pressed("exit"):
		await get_tree().create_timer(0.25).timeout 
		player.save()
		save_game()
		get_tree().change_scene_to_file("res://MainMenu/main_menu.tscn")
	

func save():
	var save_dic = {
		"player_class" : State.player_class,
		"player_name" : State.player_name,
		"lvl" : State.lvl,
		"gold" : State.gold, 
		"current_health" : State.current_health,
		"1boss" : State.boss1act,
		"armor" : State.current_armor, 
		"access" : State.current_access,
		"weapon" : State.current_weapon	, 
		"position" : position_dic
	}
	return save_dic

func save_game():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var json_string = JSON.stringify(save())
	save_game.store_line(json_string)

func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string  = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()
		for i in node_data["position"]:
			var pos = Vector2(node_data["position"][i][0], node_data["position"][i][1])
			get_node(i).update_position(pos)

