extends Node2D

var position_dic = {}

@onready var player = $Player
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
var player_body = null
#ноды врагов
@onready var boss1Node = $Boss_act1
@onready var slimeNode = $EnemySlime
@onready var wolfNode = $EnemyWolf
@onready var ravenNode = $EnemyRaven
@onready var druidNode = $Dryid
@onready var elderNode = $Elder
@onready var bardNode = $Bard
#состояние врагов
var boss1act = State.boss1act
var slime1act = State.slime1act
var wolf1act = State.wolf1act
var raven1act = State.raven1act
var druid1act = State.druid1act
var bard1act = State.bard1act
var elder1act = State.elder1act

func dialogue():
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)

func _ready():
	State.current_act = "res://world.tscn"
	load_game()
	
	
func _process(delta):
	defeat_boss1()
	defeat_slime()
	defeat_wolf()
	defeat_raven()
	defeat_elder()
	defeat_bard()
	defeat_druid()
	
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
		"act" : "res://world.tscn",
		"position" : position_dic,
		"druid" : State.druid1act,
		"elder" : State.elder1act,
		"bard" : State.bard1act,
		"1boss" : State.boss1act
	}
	return save_dic

func save_game():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var json_string = JSON.stringify(save())
	save_game.store_line(json_string)

func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		State.druid1act = true
		State.bard1act = true
		State.elder1act = true
		State.boss1act = true
		dialogue_resource = load("res://dialogues/begining.dialogue")
		dialogue()
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
	


# enemys death
func defeat_boss1():
	if boss1act:
		return
	else:
		remove_child(boss1Node)
		State.boss1act = false
		return State.boss1act
		
func defeat_slime():
	if slime1act:
		return
	else:
		remove_child(slimeNode)
		
func defeat_wolf():
	if wolf1act:
		return
	else:
		remove_child(wolfNode)
		
func defeat_raven():
	if raven1act:
		return
	else:
		remove_child(ravenNode)
		
func defeat_druid():
	if druid1act:
		return
	else:
		remove_child(druidNode)
		State.druid1act = false

func defeat_elder():
	if elder1act:
		return
	else:
		remove_child(elderNode)

func defeat_bard():
	if bard1act:
		return
	else:
		remove_child(bardNode)


func _on_area_2d_body_entered(body):
	player_body = body
	dialogue_resource = load("res://dialogues/1act_exit.dialogue")
	dialogue()


func _on_area_2d_body_exited(body):
	player_body = null
