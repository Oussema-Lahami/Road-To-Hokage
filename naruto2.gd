extends KinematicBody2D


var direction = 1

func _ready():
	$AnimatedSprite.play("default")



func set_form_direction():
	$AnimatedSprite.flip_h = true

func delete():
	queue_free()


