extends KinematicBody2D

func _ready():
	$AnimatedSprite.play("Appear")
	$Timer2.start()

func _on_JirayaArea_body_entered(_body):
	$AnimatedSprite.play("default")
	$Dialogue/ColorRect/whatsapp.play()
	get_parent().get_node("Dialogue").visible = true

func _on_JirayaArea_body_exited(_body):
	$Dialogue/ColorRect/whatsapp.stop()
	$AnimatedSprite.play("Teleport")
	get_parent().get_node("Dialogue").visible = false

func _on_Timer2_timeout():
	#$pst.play()
	pass
func stop_music():
	$pst.stop()
