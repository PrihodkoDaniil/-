class_name InventoryUI
extends ScrollContainer

@onready var inventory = $"../../../.."
@onready var container = $VBoxContainer
@onready var canvas = $"../../.."
@onready var more_info_panel = $"../../InventoryMoreInfo"
@onready var items_actions = $"../../../../ItemActions"

var selected_item := 0

func _ready():
	canvas.visible = false

func _process(delta):
	if Input.is_action_just_pressed("open_inventory") and not canvas.visible:
		canvas.visible = true
		render_items()
		render_selected()
	if Input.is_action_just_pressed("ui_cancel") and canvas.visible and more_info_panel.visible:
		more_info_panel.visible = false
	elif Input.is_action_just_pressed("ui_cancel") and canvas.visible and not more_info_panel.visible:
		canvas.visible = false

	if Input.is_action_just_pressed("ui_accept") and container.get_children().size() != 0 and canvas.visible:
		if more_info_panel.visible:
			if more_info_panel.selected_option == more_info_panel.options.DROP:
				inventory.remove_item(inventory.inventory_list[selected_item])
				more_info_panel.visible = false
				render_items()
				render_selected()  
			elif more_info_panel.selected_option == more_info_panel.options.USE:
				if inventory.inventory_list[selected_item].type == "Еда":
					items_actions.call_deferred(inventory.inventory_list[selected_item].action)
					inventory.remove_item(inventory.inventory_list[selected_item])
					more_info_panel.visible = false
					render_items()
					render_selected()  
				elif inventory.inventory_list[selected_item].type != "Еда":
					items_actions.call_deferred(inventory.inventory_list[selected_item].action)
		else:
			more_info_panel.visible = true
		
	if not canvas.visible: return
	if more_info_panel.visible: return
	
	if Input.is_action_just_pressed("ui_down") and selected_item < inventory.inventory_list.size()-1:
		selected_item += 1
		render_selected()
	elif Input.is_action_just_pressed("ui_up") and selected_item > 0:
		selected_item -= 1
		render_selected()
			

func render_selected():
	if selected_item > inventory.inventory_list.size()-1 or selected_item < 0:
		selected_item = 0
		
	for i in range(container.get_children().size()):
		if selected_item == i:
			more_info_panel.item_name = inventory.inventory_list[i].name
			more_info_panel.item_description = inventory.inventory_list[i].description
			container.get_children()[i].selected = true
			for j in range(container.get_children().size()):
				if selected_item != j:
					container.get_children()[j].selected = false

func render_items():
	if inventory.inventory_list.size() == 0:
		more_info_panel.visible = false
		
	for child in container.get_children():
		container.remove_child(child)
	for i in range(inventory.inventory_list.size()):
		var ui_item = preload("res://Inventory/inventory_ui_item.tscn")
		var ui_item_instance = ui_item.instantiate()
		ui_item_instance.item_name = inventory.inventory_list[i].name
		ui_item_instance.item_count = inventory.inventory_list[i].quantity
		container.add_child(ui_item_instance)
