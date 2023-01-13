extends KinematicBody2D



func _ready():
	pass




func _on_itachiarea_body_entered(body):
	$Timer.start()
	$speech.play()
	get_parent().get_node("Dialogue2").visible = true
	get_parent().get_node("song").stop()

func _on_Timer_timeout():
	$AnimatedSprite.play("default")
	$dead.start()
	get_parent().get_node("timerdead").start()

func _on_itachiarea_body_exited(body):
	$speech.stop()
	get_parent().get_node("Dialogue2").visible = false
	get_parent().get_node("song").play()



func _on_dead_timeout():
	$speech.stop()
	queue_free()
	get_parent().get_node("Dialogue2").visible = false
	get_parent().get_node("song").play()
