extends Control

func _ready():
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://UI/FirstMenu.tscn")
