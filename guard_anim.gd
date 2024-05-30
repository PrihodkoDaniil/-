extends Path2D

func _process(delta):
	var move_speed = 250
	$PathFollow2D.progress += move_speed * delta
