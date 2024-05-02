extends Node2D

@export var player_class : Resource = null
@export var weapon : Resource
@export var access : Resource 
@export var armor : Resource 

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_class = load("res://tres/barbarian.tres")
	weapon = State.current_weapon
	access = State.current_access
	armor = State.current_armor
	if Input.is_action_just_pressed("open_stats"):
		$CanvasLayer.show()
		set_stats()
		set_other_stats()
		set_items()
	if Input.is_action_just_pressed("ui_cancel") and $CanvasLayer.visible:
		$CanvasLayer.hide()
		
func set_stats():
	$CanvasLayer/Control/StatsPanel/GridContainer/strength.text = "Сила: %d" % player_class.strength
	$CanvasLayer/Control/StatsPanel/GridContainer/physique.text = "Выносливость: %d" % player_class.physique
	$CanvasLayer/Control/StatsPanel/GridContainer/dexterity.text = "Ловкость: %d" % player_class.dexterity
	$CanvasLayer/Control/StatsPanel/GridContainer/intelligence.text = "Интеллект: %d" % player_class.intelligence
	$CanvasLayer/Control/StatsPanel/GridContainer/wisdom.text = "Мудрость: %d" % player_class.wisdom
	$CanvasLayer/Control/StatsPanel/GridContainer/charisma.text = "Харизма: %d" % player_class.charisma
	
func set_other_stats():
	$CanvasLayer/Control/OtherStatsPanel/VBoxContainer/name.text = State.player_name
	$CanvasLayer/Control/OtherStatsPanel/VBoxContainer/lv.text = "Lv %d" % State.lvl
	$CanvasLayer/Control/OtherStatsPanel/VBoxContainer/hp.text = "HP %d/%d" %  [State.current_health, player_class.max_health]
	$CanvasLayer/Control/OtherStatsPanel/VBoxContainer/gold.text = "Gold %d" % State.gold

func set_items():
	#оружие
	if (weapon != null):
		$CanvasLayer/Control/StatsPanel/VBoxContainer/weapon.text = "Оружие: %s" % weapon.name
	else:
		$CanvasLayer/Control/StatsPanel/VBoxContainer/weapon.text = "Оружие: Нет"
	#броня
	if (armor != null):
		$CanvasLayer/Control/StatsPanel/VBoxContainer/armor.text = "Броня: %s" % armor.name
	else:
		$CanvasLayer/Control/StatsPanel/VBoxContainer/armor.text = "Броня: Нет"
	#аксессуары
	if (access != null):
		$CanvasLayer/Control/StatsPanel/VBoxContainer/accessories.text = "Аксессуар: %s" % access.name
	else:
		$CanvasLayer/Control/StatsPanel/VBoxContainer/accessories.text = "Аксессуары: Нет"
	
