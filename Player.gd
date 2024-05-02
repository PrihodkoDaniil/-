extends CharacterBody2D

var speed = 200
var direction = Vector2.ZERO
@onready var animation = $AnimatedSprite2D
@onready var actionable_finder: Area2D = $Direction/ActionableFinder
@onready var main = $"../"
var pos = []

func _input(event):
	if Input.is_action_just_pressed("save"):
		save()
		main.save_game()

func movement():
	velocity = Vector2.ZERO
	direction = Vector2(Input.get_axis("left","right"),Input.get_axis("up","down"))
	velocity = direction.normalized()*speed
	move_and_slide()
	#dialogue_lol
	if Input.is_action_just_pressed("ui_accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return
	#add animated
	if velocity== Vector2.ZERO:
		$AnimatedSprite2D.play("idle")
	elif velocity.x !=0:
		if velocity.x>0: 
			$AnimatedSprite2D.play("right") 
		else: 
			$AnimatedSprite2D.play("left")
	else:
		if velocity.y>0:
			$AnimatedSprite2D.play("down")  
		else: 
			$AnimatedSprite2D.play("up")
	
func _physics_process(_delta):
	movement()


func save():
	pos.append(position.x)
	pos.append(position.y)
	main.position_dic[name] = pos
	main.save_game()

func update_position(p):
	position = p
