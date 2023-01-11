extends Node2D
const SMOKE = preload("res://smoke.tscn")
var smoke = SMOKE.instance()


func _ready():
	#$song.play()
	smoke.scale.x = 2
	smoke.scale.y = 2
	$starting.play()
	$YSort/orochimaru.flip_right()
	$YSort/orochimaru4.flip_right()
	$YSort/orochimaru5.flip_up()
	$Timer.start()
	$Timer2.start()



func _on_Timer_timeout():
	#$song.play()
	$starting.stop()
	#Global.play_music()
	pass


func _on_Timer2_timeout():
	add_child(smoke)
	smoke.get_node("Position2D").position = $Position2D.global_position
	smoke.set_z_index(1000)
	smoke.play()
	$SmokeSound.play()
