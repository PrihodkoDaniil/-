extends CharacterBody2D


func _physics_process(delta):
	if State.boss4actlibrarian == false:
		$soul_torch3AnimatedSprite2D.play("death")
	else:
		$soul_torch3AnimatedSprite2D.play("live")
