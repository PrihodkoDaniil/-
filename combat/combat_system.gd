extends Node2D

signal ActionText_closed


@export var enemy : Resource = null
var weapon_now = State.current_weapon
var armor_now = State.current_armor
var current_enemy = State.current_enemy
var current_player_health = 0
var current_enemy_health = 0
var is_defending = false
var jail = false
# Bless RNG!!!
var rng = RandomNumberGenerator.new()

func _process(delta):
	pass

	
func set_enemy(enemy_name):
	$ActionText.hide()
	$PlayerActions.hide()
	var full_name = "res://enemy/" + enemy_name
	enemy = load(full_name)
	set_health($EnemyContainer/ProgressBar, enemy.health, enemy.health)
	set_health($PlayerPanel/PlayerData/ProgressBar, State.current_health, State.max_health)
	$EnemyContainer/Enemy.texture = enemy.texture
	current_player_health = State.current_health
	current_enemy_health = enemy.health
	$PlayerPanel/PlayerData/Label.text = State.player_name
	
	
	await get_tree().create_timer(0.25).timeout
	display_text("Началась драка с  %s! Ты настроен решительно" % enemy.name.to_upper())
	await ActionText_closed
	$PlayerActions.show()
	
	
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
		"wolf.tres":
			set_enemy("wolf.tres")
		"slime.tres":
			set_enemy("slime.tres")
		"raven.tres":
			set_enemy("raven.tres")
		"Kobold_boss.tres":
			set_enemy("Kobold_boss.tres")
		"kobold.tres":
			set_enemy("kobold.tres")
		"white_dragon.tres":
			set_enemy("white_dragon.tres")
		"oldman.tres":
			set_enemy("oldman.tres")
		"girl.tres":
			set_enemy("girl.tres")
		"fisher.tres":
			set_enemy("fisher.tres")
		"guard1.tres": 
			set_enemy("guard1.tres")
		"guard2.tres":
			set_enemy("guard2.tres")
		"druid_daughter.tres":
			set_enemy("druid_daughter.tres")
		"elf.tres":
			set_enemy("elf.tres")
		"shopman.tres":
			set_enemy("shopman.tres")
		"beggar.tres":
			set_enemy("beggar.tres")
		"advertiser.tres":
			set_enemy("advertiser.tres")
		"librarian.tres":
			set_enemy("librarian.tres")
		"lib_guard.tres":
			set_enemy("lib_guard.tres")
	
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
		current_player_health = max(0, current_player_health - enemy.damage/2 - armor_now.defence_plus)
		set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, State.max_health)
		display_text("%s наносит %d урона!" % [enemy.name, enemy.damage/2])
		await ActionText_closed
		$PlayerActions.show()
		if current_player_health <= 0 and current_enemy == "lib_guard.tres":
			$PlayerActions.hide()
			display_text("Ты не умер, но тебя обезвредили и задержали")
			await ActionText_closed
		elif current_player_health <= 0:
			$PlayerActions.hide()
			display_text("О нет...Ты погиб в бою")
			await ActionText_closed
			get_tree().change_scene_to_file("res://main_menu.tscn")
	else:
		var enemy_damage = rng.randi_range(1, enemy.damage)
		current_player_health = max(0, current_player_health - enemy_damage)
		set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, State.max_health)
		display_text("%s наносит %d урона!" % [enemy.name, enemy_damage])
		await ActionText_closed
		$PlayerActions.show()
		if current_player_health <= 0 and current_enemy == "lib_guard.tres":
			$PlayerActions.hide()
			display_text("Ты не умер, но тебя обезвредили и задержали")
			await ActionText_closed
			get_tree().change_scene_to_file("res://bad_end.tscn")
		elif current_player_health <= 0:
			$PlayerActions.hide()
			display_text("О нет...Ты погиб в бою")
			await ActionText_closed
			get_tree().change_scene_to_file("res://main_menu.tscn")
	
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
		match State.current_enemy:
			"Druid.tres":
				State.druid1act = false
			"Bard.tres":
				State.bard1act = false
			"Elder.tres":
				State.elder1act = false
			"Boss1.tres":
				State.boss1act = false
			"wolf.tres":
				State.wolf1act = false
			"slime.tres":
				State.slime1act = false
			"raven.tres":
				State.raven1act = false
			"Kobold_boss.tres":
				State.bosskobold2act = false
			"kobold.tres":
				State.kobold2act = false
			"white_dragon.tres":
				State.bossdragon2act = false
			"oldman.tres":
				State.oldman = false
				State.girl = false
				State.fisher = false
			"girl.tres":
				State.oldman = false
				State.girl = false
				State.fisher = false
			"fisher.tres":
				State.oldman = false
				State.girl = false
				State.fisher = false
			"guard1.tres": 
				State.guard1 = false
			"guard2.tres":
				State.guard2 = false
			"druid_daughter.tres":
				State.druid_daughter = false
				State.shopman = false
			"elf.tres":
				State.elf = false
			"shopman.tres":
				State.shopman = false
				State.druid_daughter = false
			"beggar.tres":
				State.beggar = false
			"advertiser.tres":
				State.advertiser = false
			"librarian.tres":
				State.boss4actlibrarian = false
			"lib_guard.tres":
				State.lib_guard = false
			
		display_text("%s был побежден!" % enemy.name)
		await  ActionText_closed
		await get_tree().create_timer(0.25).timeout
		get_tree().change_scene_to_file(State.current_act)
	
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
	enemy_turn()

