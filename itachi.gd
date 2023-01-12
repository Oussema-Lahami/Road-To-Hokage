extends KinematicBody2D



func _ready():
	pass # Replace with function body.




func _on_itachiarea_body_entered(body):
	$AnimatedSprite.play("default")
