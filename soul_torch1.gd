extends CharacterBody2D


func _physics_process(delta):
	if State.druid1act == false:
		$soul_torch1AnimatedSprite2D.play("death")
	else:
		$soul_torch1AnimatedSprite2D.play("live")
	#if State.bossdragon2act == false:
		#$"../soul_torch2/soul_torch2AnimatedSprite2D".play("death")
	#elif State.bossdragon2act == true:
		#$"../soul_torch2/soul_torch2AnimatedSprite2D".play("live")
		#
	#if State.boss4actlibrarian == false:
		#$"../soul_torch3/soul_torch3AnimatedSprite2D".play("death")
	#elif State.boss4actlibrarian == true:
		#$"../soul_torch3/soul_torch3AnimatedSprite2D".play("live")
