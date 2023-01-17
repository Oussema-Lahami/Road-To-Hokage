extends Node2D
var levelname = preload("res://Levels/LevelName.tscn")

func _ready():
	Global.current_level=3
	var level_name = levelname.instance()
	add_child(level_name)
	$Timer.start()

func _on_Timer_timeout():
	$song.play()


func _on_Final_Battle_body_entered(body):
	$song.stop()
	#$Final_Battle/Final_Battle2.play()

