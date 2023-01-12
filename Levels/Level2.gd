extends Node2D
var levelname = preload("res://Levels/LevelName.tscn")
const SMOKE = preload("res://smoke.tscn")
var smoke = SMOKE.instance()


func _ready():
	var level_name = levelname.instance()
	add_child(level_name)
	#smoke.scale.x = 2
	#smoke.scale.y = 2
	#$starting.play()
	$Timer.start()
	#$Timer2.start()
func _on_Timer_timeout():
	$song.play()
	#$starting.stop()
	#Global.play_music()
	pass
