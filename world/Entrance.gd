extends Area2D

# warning-ignore:unused_argument
func _on_Entrance_body_entered(body):
	SceneTransition.change_scene("res://Levels/Level2.tscn")

