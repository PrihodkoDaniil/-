extends AudioStreamPlayer


func play_sound(file_path : String):
	var full_path = "res://audio/sound_effects/" + file_path
	var sound_stream = load(full_path)
	stream = sound_stream
	stop()
	play()
