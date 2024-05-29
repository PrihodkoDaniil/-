extends Node2D

var position_dic = {}

@onready var player = $Player
var player_body = null
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
#ноды врагов
@onready var druid_daughterNode = $dryid_daughter
@onready var elfNode = $shopwoman
@onready var shopmanNode = $shopman
@onready var beggarNode = $beggar
@onready var advertiserNode = $advertiser
@onready var librarianNode = $librarian
@onready var lib_guardNode = $lib_guardian
#состояния врагов
var druid_daughter4act = State.druid_daughter
var elf4act = State.elf
var shopman4act = State.shopman
var beggar4act = State.beggar
var advertiser4act = State.advertiser
var librarian4act = State.boss4actlibrarian
var libguard4act = State.lib_guard

func _ready():
	State.current_act = "res://act_4.tscn"
	load_game()
	
func _process(delta):
	tp_to_library()
	tp_to_town()
	defeat_daughter()
	defeat_elf()
	defeat_shopman()
	defeat_advertiser()
	defeat_librarian()
	defeat_lib_guard()
	
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
		"act" : "res://act_4.tscn",
		"position" : position_dic,
		"druid" : State.druid1act,
		"dragonboss" : State.bossdragon2act, 
		
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
				node_data["position"][i][0] = 437
				node_data["position"][i][1] = -182
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
			State.bossdragon2act = node_data["dragonboss"]

func tp_to_library():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string  = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()
		if State.library_enter == true:
			for i in node_data["position"]:
				node_data["position"][i][0] = 13596
				node_data["position"][i][1] = 393
				var pos = Vector2(node_data["position"][i][0], node_data["position"][i][1])
				get_node(i).update_position(pos)
			State.library_enter = false

func tp_to_town():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string  = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()
		if State.library_exit == true:
			for i in node_data["position"]:
				node_data["position"][i][0] = 5482
				node_data["position"][i][1] = -658
				var pos = Vector2(node_data["position"][i][0], node_data["position"][i][1])
				get_node(i).update_position(pos)
			State.library_exit = false

func dialogue():
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)


func _on_library__enter_area_entered(area):
	player_body = area
	dialogue_resource = load("res://dialogues/library_enter.dialogue")
	dialogue()


func _on_library__enter_area_exited(area):
	player_body = null


func _on_library_exit_area_entered(area):
	player_body = area
	dialogue_resource = load("res://dialogues/library_exit.dialogue")
	dialogue()


func _on_library_exit_area_exited(area):
	player_body = null

func defeat_daughter():
	if druid_daughter4act:
		return
	else:
		remove_child(druid_daughterNode)
	
func defeat_elf():
	if elf4act:
		return
	else:
		remove_child(elfNode)
	
func defeat_shopman():
	if shopman4act:
		return
	else:
		remove_child(shopmanNode)
		
func defeat_beggar():
	if beggar4act:
		return
	else:
		remove_child(beggarNode)
	
func defeat_advertiser():
	if advertiser4act:
		return
	else:
		remove_child(advertiserNode)
	
func defeat_librarian():
	if librarian4act:
		return
	else:
		remove_child(librarianNode)

func defeat_lib_guard():
	if libguard4act:
		return
	else:
		remove_child(lib_guardNode)
