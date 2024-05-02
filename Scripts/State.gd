extends Node

var rng = RandomNumberGenerator.new()

var current_health = 25
var max_health = 35
var damage = 20


func go_to_battle():
	get_tree().change_scene_to_file("res://combat/combat_system.tscn")
