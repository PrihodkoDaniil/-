extends CharacterBody2D

@export var speed = 150
@export var wander_direction : Node2D
var player_chase = false
var player = null

func _on_action_area_body_entered(body):
	player = body
	player_chase = true
	await get_tree().create_timer(0.25).timeout
	State.current_enemy = "wolf.tres"
	State.go_to_battle()



func _on_action_area_body_exited(body):
	player = null
	player_chase = false



func _physics_process(delta):
	$AnimatedSprite2D.play("Move")
	velocity = wander_direction.direction * speed
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h=true
	else:
		$AnimatedSprite2D.flip_h=false
	move_and_slide()
