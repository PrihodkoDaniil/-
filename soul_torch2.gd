extends CharacterBody2D


func _physics_process(delta):
	if State.bossdragon2act == false:
		$soul_torch2AnimatedSprite2D.play("death")
	else:
		$soul_torch2AnimatedSprite2D.play("live")
