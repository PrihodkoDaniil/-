extends CharacterBody2D
 
var speed = 90


func _process(delta):
	if State.move == false:
		$AnimatedSprite2D2.play("idle")
	else:
		$"..".progress += delta * speed
		if $"..".position.x < 6 and $"..".position.y > -65:
			$AnimatedSprite2D2.play("up")
		if $"..".position.x < 6 and   $"..".position.y > -67 and $"..".position.y < -65:
			$AnimatedSprite2D2.play("left")
		if $"..".position.y >= -66 and $"..".position.x < -97 :
			$AnimatedSprite2D2.play("down")
		move_and_slide()

