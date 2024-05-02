extends Node2D
class_name Inventory

var inventory_list := [] # List to store inv items
@onready var inventory_ui =  $CanvasLayer/Control/InventoryPanel/ScrollContainer
signal update

func _process(delta):
	loot()
	if Input.is_action_just_pressed("add_item"):
		add_item(load('res://inventory/items/axe.tres'))
		add_item(load('res://inventory/items/Cookie.tres'))
<<<<<<< HEAD
		add_item(load('res://inventory/items/small_candy.tres'))
		add_item(load('res://inventory/items/ring.tres'))
		add_item(load('res://inventory/items/leather_armor.tres'))
=======
		add_item(load('res://inventory/items/blue_flower.tres'))
		add_item(load('res://inventory/items/fancy_glasses.tres'))
		add_item(load('res://inventory/items/short_sword.tres'))
>>>>>>> 80a01d0f6cee8989e3be3832a889402d134329c1
		inventory_ui.render_items()
	
func loot():
	if State.loot == true:
		emit_signal("update")
	elif State.loot == false:
		return

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
