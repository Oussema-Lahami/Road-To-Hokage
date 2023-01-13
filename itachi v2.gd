extends KinematicBody2D


func _ready():
	$AnimatedSprite.play("stance")


func _on_Area2D_area_entered(area):
	$AnimatedSprite.play("katon")
