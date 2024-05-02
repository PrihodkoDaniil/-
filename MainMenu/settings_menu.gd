extends Node2D

var master_bus = AudioServer.get_bus_index("Master")
@onready var resol_btn = $CanvasLayer/Panel/VBoxContainer/OptionButton as OptionButton

const resolutions  = {
	"1280 x 1024" : Vector2i(1280, 1024),
	"1280 x 720" : Vector2i(1280, 720),
	"1440 x 900" : Vector2i(1440, 900)
}

func _ready():
	resol_btn.item_selected.connect(on_resol_selected)
	add_resol_items()

func on_resol_selected(index : int):
	DisplayServer.window_set_size(resolutions.values()[index])

func add_resol_items():
	for resol_size_text in resolutions:
		resol_btn.add_item(resol_size_text)


func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	
	if value == -30:
		AudioServer.set_bus_mute(master_bus, true)
	else: 
		AudioServer.set_bus_mute(master_bus, false)

func _on_back_pressed():
	get_tree().change_scene_to_file("res://MainMenu/main_menu.tscn")
