extends CharacterBody2D

var speed = 200
var direction = Vector2.ZERO
@onready var animation = $AnimatedSprite2D
func movement():
	velocity = Vector2.ZERO
	direction = Vector2(Input.get_axis("left","right"),Input.get_axis("up","down"))
	velocity = direction.normalized()*speed
	move_and_slide()
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
