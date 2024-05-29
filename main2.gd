extends Node2D

var position_dic = {}

@onready var player = $Player
var player_body = null
#ноды врагов
@onready var bosskobold2Node = $Kobold_boss
@onready var koboldNode = $Kobold
@onready var bossdragonNode = $Dragon
#состояние врагов
var koboldboss2act = State.bosskobold2act
var kobold2act = State.kobold2act
var dragonboss2act = State.bossdragon2act


func _ready():
	State.current_act = "res://act_2.tscn"
	load_game()
	
	
func _process(delta):
	defeat_koboldboss()
	defeat_kobold()
	defeat_dragon()
	
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
		"max_health" : State.max_health,
		"damage" : State.damage,
		"armor" : State.current_armor, 
		"access" : State.current_access,
		"weapon" : State.current_weapon	,
		"act" : "res://act_2.tscn",
		"position" : position_dic,
		"druid" : State.druid1act,
		"elder" : State.elder1act,
		"bard" : State.bard1act,
		"1boss" : State.boss1act,
		"smallkobold" : State.kobold2act,
		"koboldboss" : State.bosskobold2act, 
		"dragonboss" : State.bossdragon2act
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
		if State.first_enter == true:
			for i in node_data["position"]:
				node_data["position"][i][0] = 505
				node_data["position"][i][1] = 41
				var pos = Vector2(node_data["position"][i][0], node_data["position"][i][1])
				get_node(i).update_position(pos)
			State.first_enter = false
		else:
			for i in node_data["position"]:
				var pos = Vector2(node_data["position"][i][0], node_data["position"][i][1])
				get_node(i).update_position(pos)
			State.player_name = node_data["player_name"]
			State.gold = node_data["gold"]
			State.lvl = node_data["lvl"]
			State.current_health = node_data["current_health"]
			State.max_health = node_data["max_health"]
			State.damage = node_data["damage"]
			State.druid1act = node_data["druid"]
			State.elder1act = node_data["elder"]
			State.bard1act = node_data["bard"]
			State.boss1act = node_data["1boss"]
			State.kobold2act = node_data["smallkobold"]
			State.bosskobold2act = node_data["koboldboss"]
			State.bossdragon2act = node_data["dragonboss"]
		

func defeat_koboldboss():
	if koboldboss2act:
		return
	else:
		remove_child(bosskobold2Node)
		
func defeat_kobold():
	if kobold2act:
		return
	else:
		remove_child(koboldNode)
		
func defeat_dragon():
	if dragonboss2act:
		return
	else:
		remove_child(bossdragonNode)

