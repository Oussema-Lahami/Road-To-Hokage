extends KinematicBody2D

func _ready():
	
	$AnimatedSprite.play("default")


func _on_RavenArea_body_entered(body):
	$caw.play()


func _on_RavenArea_body_exited(body):
	$caw.stop()
