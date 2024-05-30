extends CharacterBody2D

var speed = 200

func _physics_process(delta):
	$AnimatedSprite2D.play("idle")
