class_name Inventory
extends Node2D

var inventory := [] # List to store inv items
@export var inventory_ui : InventoryUI

func _process(delta):
	if Input.is_action_just_pressed("add_item"):
		add_item(load('res://inventory/items/axe.tres'))
		add_item(load('res://inventory/items/Cookie.tres'))
		add_item(load('res://inventory/items/blue_flower.tres'))
		add_item(load('res://inventory/items/fancy_glasses.tres'))
		add_item(load('res://inventory/items/short_sword.tres'))
		inventory_ui.render_items()

#---Function adds a new item to the inventory---#
func add_item(item : ItemResource) -> void:
	for index in range(inventory.size()):
		if item.name == inventory[index].name:
			inventory[index].quantity += 1
			return
	inventory.append(item)

#---Function that removes an item from the inventory---#
func remove_item(item : ItemResource) -> void:
	for index in range(inventory.size()):
		if item.name == inventory[index].name:
			if item.quantity > 1:
				inventory[index].quantity -= 1
			else:
				inventory.erase(item)
			return

