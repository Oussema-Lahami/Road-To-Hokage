extends Node2D
var levelname = preload("res://Levels/LevelName.tscn")

func _ready():
	Global.current_level=3
	var level_name = levelname.instance()
	add_child(level_name)
	$Timer.start()

func _on_Timer_timeout():
	$song.play()
