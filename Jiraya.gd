extends KinematicBody2D

func _ready():
	$AnimatedSprite.play("Appear")

func _on_JirayaArea_body_entered(_body):
	$AnimatedSprite.play("Teleport")
	get_parent().get_node("Dialogue").visible = true

func _on_JirayaArea_body_exited(_body):
	$AnimatedSprite.play("default")
	get_parent().get_node("Dialogue").visible = false
