extends Node2D

var position_dic = {}

@onready var player = $Player
var player_body = null
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
#ноды врагов
@onready var oldmanNode = $Oldman
@onready var girlNode = $Girl
@onready var fisherNode = $Fisher
@onready var guard1Node = $Guardians_Boss
@onready var guard2Node = $Guardians_Boss2
#состояния врагов
var oldman3act = State.oldman
var girl3act = State.girl
var fisher3act = State.fisher
var guard1 = State.guard1
var guard2 = State.guard2

func _ready():
	State.current_act = "res://act_3.tscn"
	load_game()
	
func _process(delta):
	tp_to_bar()
	tp_to_village()
	return_to_bar()
	defeat_oldman()
	defeat_girl()
	defeat_fisher()
	defeat_guard1()
	defeat_guard2()
	
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
		"act" : "res://act_3.tscn",
		"position" : position_dic,
		"druid" : State.druid1act,
		"elder" : State.elder1act,
		"bard" : State.bard1act,
		"1boss" : State.boss1act,
		"smallkobold" : State.kobold2act,
		"koboldboss" : State.bosskobold2act, 
		"dragonboss" : State.bossdragon2act, 
		"bar_enter" : State.bar_not_enter, 
		"girl" : State.girl, 
		"oldman" : State.oldman, 
		"fisher" : State.fisher, 
		"guard1" : State.guard1, 
		"guard2" : State.guard2
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
				node_data["position"][i][0] = 114
				node_data["position"][i][1] = -158
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
			State.bar_not_enter = node_data["bar_enter"]
			State.girl = node_data["girl"]
			State.oldman = node_data["oldman"]
			State.fisher = node_data["fisher"]
			State.guard1 = node_data["guard1"]
			State.guard2 = node_data["guard2"]


func tp_to_bar():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string  = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()
		if State.bar == true:
			for i in node_data["position"]:
				node_data["position"][i][0] = 1518
				node_data["position"][i][1] = -2982
				var pos = Vector2(node_data["position"][i][0], node_data["position"][i][1])
				get_node(i).update_position(pos)
			State.bar = false

func tp_to_village():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string  = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()
		if State.village == true:
			for i in node_data["position"]:
				node_data["position"][i][0] = 3720
				node_data["position"][i][1] = -505
				var pos = Vector2(node_data["position"][i][0], node_data["position"][i][1])
				get_node(i).update_position(pos)
			State.village = false

func return_to_bar():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string  = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()
		if State.enter_bar == true:
			for i in node_data["position"]:
				node_data["position"][i][0] = 1867
				node_data["position"][i][1] = -3080
				var pos = Vector2(node_data["position"][i][0], node_data["position"][i][1])
				get_node(i).update_position(pos)
			State.enter_bar = false

func dialogue():
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)

func _on_podval_exit_area_entered(area):
	player_body = area
	dialogue_resource = load("res://dialogues/podval_exit.dialogue")
	dialogue()

func _on_podval_exit_area_exited(area):
	player_body = null


func _on_bar_exit_area_entered(area):
	player_body = area
	dialogue_resource = load("res://dialogues/bar_exit.dialogue")
	dialogue()


func _on_bar_exit_area_exited(area):
	player_body = null


func _on_bar_enter_area_entered(area):
	player_body = area
	dialogue_resource = load("res://dialogues/bar_enter.dialogue")
	dialogue()


func _on_bar_enter_area_exited(area):
	player_body = null

func defeat_oldman():
	if oldman3act:
		return
	else:
		remove_child(oldmanNode)

func defeat_girl():
	if girl3act:
		return
	else:
		remove_child(girlNode)
		
func defeat_fisher():
	if fisher3act:
		return
	else:
		remove_child(fisherNode)

func defeat_guard1():
	if guard1:
		return
	else:
		remove_child(guard1Node)
		
func defeat_guard2():
	if guard2:
		return
	else:
		remove_child(guard2Node)


func _on_act_enter_area_entered(area):
	player_body = area
	dialogue_resource = load("res://dialogues/fourth_act_enter.dialogue")
	dialogue()


func _on_act_enter_area_exited(area):
	player_body = null
