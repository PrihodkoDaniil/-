extends Node2D
class_name Inventory

var inventory_list = State.inv
@onready var inventory_ui =  $CanvasLayer/Control/InventoryPanel/ScrollContainer
signal update

func _process(delta):
	loot()
	loot_carrot()
	loot_new_axe()
	
func _ready():
	add_item(load("res://inventory/items/axe.tres"))
	add_item(load("res://inventory/items/Cookie.tres"))
	add_item(load("res://inventory/items/small_candy.tres"))
	add_item(load("res://inventory/items/small_candy.tres"))
	add_item(load("res://inventory/items/leather_armor.tres"))
	add_item(load("res://inventory/items/ring.tres"))
	inventory_ui.render_items()
		
func loot():
	if State.loot == true:
		emit_signal("update")
	elif State.loot == false:
		return

func loot_new_axe():
	if State.new_axe == true:
		add_item(load("res://inventory/items/new_axe.tres"))
		State.new_axe = false
	else:
		return
	inventory_ui.render_items()

func loot_carrot():
	if State.carrot == true:
		add_item(load("res://inventory/items/carrot.tres"))
		State.carrot = false
	else:
		return
	inventory_ui.render_items()

#---Function adds a new item to the inventory---#
func add_item(item : ItemResource) -> void:
	for index in range(inventory_list.size()):
		if item.name == inventory_list[index].name:
			inventory_list[index].quantity += 1
			return
	inventory_list.append(item)

#---Function that removes an item from the inventory---#
func remove_item(item : ItemResource) -> void:
	for index in range(inventory_list.size()):
		if item.name == inventory_list[index].name:
			if item.quantity > 1:
				inventory_list[index].quantity -= 1
			else:
				inventory_list.erase(item)
			return
