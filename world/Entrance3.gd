extends Area2D

func _on_Entrance3_body_entered(body):
	SceneTransition.change_scene("res://UI/winning-gam.tscn")
