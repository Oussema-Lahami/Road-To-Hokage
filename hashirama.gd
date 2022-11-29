extends KinematicBody2D
var DRAGON = preload("res://dragon.tscn")



#just to test later to be added ai
func _physics_process(delta):
	if Input.is_action_just_pressed("throw"):
		$Timer.start()
		$AnimatedSprite.play("default")




func _on_Timer_timeout():
		var dragon = DRAGON.instance()
		if $AnimatedSprite.flip_h == true: 
			dragon.flip()
		get_parent().add_child(dragon)
		dragon.global_position = $Position2D.global_position
