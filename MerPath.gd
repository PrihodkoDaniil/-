extends CharacterBody2D

var speed = 100

func _process(delta):
	if State.mer_move == false:
		$AnimatedSprite2D.play("idle")
	else:
		$"..".progress += delta * speed
		if $"..".position.x > -1149 and $"..".position.y < -75:
			$AnimatedSprite2D.play("walk")
		if $"..".position.x == -662 and $"..".position.y == -79:
			$AnimatedSprite2D.play("idle")
		

