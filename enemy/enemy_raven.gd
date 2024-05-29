extends CharacterBody2D

@export var speed = 100
@export var wander_direction : Node2D
var player_chase = false
var player = null


func _physics_process(delta):
	velocity = wander_direction.direction * speed
	$AnimatedSprite2D.play("Move")
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h=false
	else:
		$AnimatedSprite2D.flip_h=true
	move_and_slide()




func _on_area_2d_body_entered(body):
	player = body
	player_chase = true
	await get_tree().create_timer(0.5).timeout
	State.current_enemy = "raven.tres"
	State.go_to_battle()


func _on_area_2d_body_exited(body):
	player = null
	player_chase = false
