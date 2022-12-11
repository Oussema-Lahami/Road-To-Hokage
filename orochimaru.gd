extends KinematicBody2D


func _on_attack_body_entered(body):
	$AnimatedSprite.play("down")




func _on_attack_body_exited(body):
	$AnimatedSprite.stop()
