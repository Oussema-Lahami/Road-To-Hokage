extends Area2D

func _on_Entrance2_body_entered(body):
	SceneTransition.change_scene("res://Levels/Level3.tscn")
