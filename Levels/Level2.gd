extends Node2D
var levelname = preload("res://Levels/LevelName.tscn")
const SMOKE = preload("res://smoke.tscn")
var smoke = SMOKE.instance()

func _ready():
	$Danzo.flip_right()
	$Danzo2.flip_right()
	$narutoyezzy.start()
	Global.current_level=2
	$NarutoTalk.play()
	yield(get_tree().create_timer(3), "timeout")
	var level_name = levelname.instance()
	add_child(level_name)
	$Timer.start()

func _on_Timer_timeout():
	$song.play()

func _on_timerdead_timeout():
	$ravens.visible = true

func _on_narutoyezzy_timeout():
	$NarutoTalk.stop()

