extends KinematicBody2D
var KATON = preload("res://katon.tscn")


func _ready():
	$AnimatedSprite.play("stance")



func _on_shoot_timeout():
	var katon = KATON.instance()
	if $AnimatedSprite.flip_h == true: 
		katon.set_katon_direction(Vector2(-1 , -1))
	get_parent().add_child(katon)
	katon.global_position = $Position2D.global_position
	$AnimatedSprite.play("stance")


func _on_attack2_area_entered(area):
	$katon.play()
	$katonStop.start()
	$AnimatedSprite.play("katon")
	$shoot.start()


func _on_attack2_area_exited(area):
	$AnimatedSprite.play("stance")


func _on_katonStop_timeout():
	$katon.stop()
