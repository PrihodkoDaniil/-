extends Node2D

#другое
var rng = RandomNumberGenerator.new()

#статы_персонажа
@export var player_class : Resource
var player_name = "Генадий"
var lvl = 1
var gold = 1
var current_health = 15
var max_health : int
var damage = 20
var current_armor : Resource
var current_weapon = load("res://inventory/items/axe.tres")
var current_access : Resource
#вспомогательные переменные
var check : int
var loot = false
var weapon = false
var access = false
var armor = false

@export var current_enemy : String
# боссы
var boss1act = true

func _ready():
	player_class = load("res://tres/barbarian.tres")
	max_health = player_class.max_health
  
  
func _process(delta):
	set_weapon()
	set_access()
	set_armor()
  

func set_weapon():
	if weapon == false:
		return
	elif weapon == true:
		State.current_weapon = load("res://inventory/items/axe.tres")


func set_access():
	if access == false:
		return
	elif access == true:
		State.current_access = load("res://inventory/items/ring.tres")
		player_class.intelligence = 10

func set_armor():
	if armor == false:
		return
	elif armor == true:
		State.current_armor = load("res://inventory/items/leather_armor.tres")
	
	
func check_dexterity():
	var mod = (player_class.dexterity - 10)/2
	check = rng.randi_range(1, 20) + mod
	return check

func go_to_battle():
	get_tree().change_scene_to_file("res://combat/combat_system.tscn")
  
func guitar_melody():
	SoundPlayer.play_sound("acoustic-guitar-melody.wav")

func barking():
	SoundPlayer.play_sound("barking.wav")
  
func inv_signal():
	loot = true
	return loot
  
  
# вставное говно

@export var item : Resource




func heal_cookie():
	item = load("res://inventory/items/Cookie.tres")
	State.current_health += item.health_restored
	if State.current_health > State.max_health:
		State.current_health = State.max_health
	
	
func heal_candy():
	item = load("res://inventory/items/small_candy.tres")
	State.current_health += item.health_restored
	if State.current_health > State.max_health:
		State.current_health = State.max_health
	
func set_axe():
	weapon_signal()

func set_ring():
	access_signal()

func set_leather():
	armor_signal()
  
func weapon_signal():
	weapon = true
	return weapon

func access_signal():
	access = true
	return access

func armor_signal():
	armor = true
	return armor

func minus_gold(g : int):
	State.gold = max(0, State.gold-g)
	return State.gold
