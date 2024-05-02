extends Node2D
<<<<<<< HEAD

signal ActionText_closed


@export var enemy : Resource = null
var weapon_now = State.current_weapon
var armor_now = State.current_armor
=======
class_name Combat

signal ActionText_closed

@export var enemy : Resource = null
@export var weapon_now : Resource = null
>>>>>>> 80a01d0f6cee8989e3be3832a889402d134329c1

var current_player_health = 0
var current_enemy_health = 0
var is_defending = false
<<<<<<< HEAD
=======

>>>>>>> 80a01d0f6cee8989e3be3832a889402d134329c1
# Bless RNG!!!
var rng = RandomNumberGenerator.new()
	
	
func _process(delta):
	pass

<<<<<<< HEAD
	
func set_enemy(enemy_name):
	$ActionText.hide()
	$PlayerActions.hide()
	var full_name = "res://enemy/" + enemy_name
	enemy = load(full_name)
=======
# Called when the node enters the scene tree for the first time.
func _ready():
	$ActionText.hide()
	$PlayerActions.hide()
	enemy = load("res://enemy/Druid.tres")
	weapon_now = load("res://inventory/items/axe.tres")
>>>>>>> 80a01d0f6cee8989e3be3832a889402d134329c1
	set_health($EnemyContainer/ProgressBar, enemy.health, enemy.health)
	set_health($PlayerPanel/PlayerData/ProgressBar, State.current_health, State.max_health)
	$EnemyContainer/Enemy.texture = enemy.texture
	current_player_health = State.current_health
	current_enemy_health = enemy.health
<<<<<<< HEAD
	$PlayerPanel/PlayerData/Label.text = State.player_name
	
	
	await get_tree().create_timer(0.25).timeout
	display_text("Началась драка с  %s! Ты настроен решительно" % enemy.name.to_upper())
=======
	
	
	await get_tree().create_timer(0.25).timeout
	display_text("О нет! Это же %s! Тебе жутко от его присутствия" % enemy.name.to_upper())
>>>>>>> 80a01d0f6cee8989e3be3832a889402d134329c1
	await ActionText_closed
	$PlayerActions.show()
	
	
<<<<<<< HEAD
# Called when the node enters the scene tree for the first time.
func _ready():
	match State.current_enemy:
		"Druid.tres":
			set_enemy("Druid.tres")
		"Bard.tres":
			set_enemy("Bard.tres")
		"Elder.tres":
			set_enemy("Elder.tres")
		"Boss1.tres":
			set_enemy("Boss1.tres")
=======

>>>>>>> 80a01d0f6cee8989e3be3832a889402d134329c1
	
func _input(event):
	if (Input.is_action_just_pressed("ui_accept") or 
	Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and $ActionText.visible:
		await get_tree().create_timer(0.25).timeout
		$ActionText.hide()
		emit_signal("ActionText_closed")


func display_text(text):
	$ActionText.show()
	$ActionText/Label.text = text

func set_health(progress_bar, health, max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Label").text = "HP: %d/%d" % [health, max_health]
	

func enemy_turn():
	$PlayerActions.hide()
	display_text("Атакует %s! Посмотрим кто кого" % enemy.name.to_upper())
	await ActionText_closed
	$AnimationPlayer.play("enemy_damage_you")
	if is_defending:
		is_defending = false
<<<<<<< HEAD
		current_player_health = max(0, current_player_health - enemy.damage/2 - armor_now.defence_plus)
=======
		current_player_health = max(0, current_player_health - enemy.damage/2)
>>>>>>> 80a01d0f6cee8989e3be3832a889402d134329c1
		set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, State.max_health)
		display_text("%s наносит %d урона!" % [enemy.name, enemy.damage/2])
		await ActionText_closed
		$PlayerActions.show()
	else:
		current_player_health = max(0, current_player_health - enemy.damage)
		set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, State.max_health)
		display_text("%s наносит %d урона!" % [enemy.name, enemy.damage])
		await ActionText_closed
		$PlayerActions.show()
	
# Код для 4 кнопок в окне боя
func _on_attack_pressed():
	$PlayerActions.hide()
	display_text("Ты атакуешь врага. Ему это не нравится...")
	await ActionText_closed
	rng.randomize()
	var total_damage = State.damage + rng.randi_range(1,weapon_now.atk_plus)
	current_enemy_health =  max(0, current_enemy_health - total_damage)
	set_health($EnemyContainer/ProgressBar, current_enemy_health, enemy.health)
	display_text("Ты наносишь %s урона!" % total_damage)
	$AnimationPlayer.play("enemy_damage")
	await ActionText_closed
	if current_enemy_health == 0:
		display_text("%s был побежден!" % enemy.name)
		await  ActionText_closed
		await get_tree().create_timer(0.25).timeout
		get_tree().change_scene_to_file("res://world.tscn")
	
	$PlayerActions.show()
	enemy_turn()


func _on_run_pressed():
	$PlayerActions.hide()
	display_text("Беги гномик бегиии!!!")
	await ActionText_closed
	get_tree().change_scene_to_file("res://world.tscn")

func _on_defence_pressed():
	is_defending = true
	$PlayerActions.hide()
	display_text("Ты встал в защитную стойку")
	await ActionText_closed
<<<<<<< HEAD
=======
	$AnimationPlayer.play("defend")
>>>>>>> 80a01d0f6cee8989e3be3832a889402d134329c1
	enemy_turn()

