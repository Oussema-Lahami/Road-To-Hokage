extends KinematicBody2D


func _on_attack_body_entered(body):
	if $AnimatedSprite.animation == "right" :
		$AnimatedSprite.play("right")
	elif $AnimatedSprite.animation == "up" :
		$AnimatedSprite.play("up")
	else:
		$AnimatedSprite.play("down")




func _on_attack_body_exited(body):
	$AnimatedSprite.stop()
	

func flip_right():
	$AnimatedSprite.flip_h = true
	$AnimatedSprite.animation = "right"
	
func flip_up():
	$AnimatedSprite.animation = "up"


func _on_Hurtbox_area_entered(area):
	queue_free()
