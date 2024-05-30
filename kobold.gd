extends CharacterBody2D

@export var speed = 200
@export var wander_direction : Node2D
var player_chase = false
var player = null
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

func _physics_process(delta):
	$AnimatedSprite2D.play("Move")
	velocity = wander_direction.direction * speed
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h=true
	else:
		$AnimatedSprite2D.flip_h=false
	move_and_slide()

func dialogue():
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)

func _on_area_2d_body_entered(body):
	player = body
	player_chase = true
	await get_tree().create_timer(0.25).timeout
	dialogue()


func _on_area_2d_body_exited(body):
	player = null
	player_chase = false
