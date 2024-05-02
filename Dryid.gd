extends CharacterBody2D

func _physics_process(delta):
	# Add the gravity.
	$AnimatedSprite2D2.play("idle")
