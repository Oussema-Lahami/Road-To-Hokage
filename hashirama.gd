extends KinematicBody2D
var DRAGON = preload("res://dragon.tscn")

var attack = false 

func _on_Timer_timeout():
		var dragon = DRAGON.instance()
		if $AnimatedSprite.flip_h == true: 
			dragon.flip()
			get_parent().add_child(dragon)
			dragon.global_position = $Position2D2.global_position
		else :
			get_parent().add_child(dragon)
			dragon.global_position = $Position2D.global_position

func _on_attack_body_entered(body):
	attack = true
	$Timer.start()
	$AnimatedSprite.play("default")
