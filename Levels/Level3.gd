extends Node2D
var levelname = preload("res://Levels/LevelName.tscn")

func _ready():
	var level_name = levelname.instance()
	add_child(level_name)
