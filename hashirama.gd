extends KinematicBody2D
var DRAGON = preload("res://dragon.tscn")

var attack = false 
var dragon = DRAGON.instance()

func _on_Timer_timeout():
	
	if $AnimatedSprite.flip_h == true: 
		dragon.flip()
		get_parent().add_child(dragon)
		dragon.global_position = $Position2D2.global_position
		dragon.play()
	else :
		get_parent().add_child(dragon)
		dragon.global_position = $Position2D.global_position
		dragon.play()

func _on_attack_body_entered(body):
	if attack == true:
		$Timer.start()
		$AnimatedSprite.play("default")
	attack = true


func _on_attack_body_exited(body):
	dragon.reset()
	$AnimatedSprite.play("idle")
