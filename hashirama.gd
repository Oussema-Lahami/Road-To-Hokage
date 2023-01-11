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
	$Timer.start()
	$AnimatedSprite.play("default")




func _on_attack_body_exited(body):
	dragon.reset()
	$AnimatedSprite.play("idle")


func _on_Hurtbox_area_entered(area):
	queue_free()
