extends Node2D



func _ready():
	#$song.play()
	$YSort/orochimaru.flip_right()
	$YSort/orochimaru4.flip_right()
	$YSort/orochimaru5.flip_up()
	$Timer.start()


func _on_Timer_timeout():
	#$song.play()
	pass
