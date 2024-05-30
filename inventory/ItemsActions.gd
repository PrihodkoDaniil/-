extends Node

@export var item : Resource


func _process(delta):
	pass

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
	pass
	
func set_ring():
	pass

