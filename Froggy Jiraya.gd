extends KinematicBody2D
var current_level = Global.current_level
#func _ready():
	#if current_level == 1:
	#	$AnimatedSprite.play("jrana") 
	#elif current_level == 2:
	#	$AnimatedSprite.play("Appear")
	#$Timer2.start()
	
func _ready():
	#$Dialogue/ColorRect/whatsapp.play()
	$Jiraya/AnimatedSprite.play("jrana")
#	$Timer2.start()

func _on_JirayaArea_body_entered(_body):
	$Jiraya/AnimatedSprite.play("jranadefault")
	$Jiraya/Dialogue/ColorRect/whatsapp.play()
	get_parent().get_node("Dialogue").visible = true

func _on_JirayaArea_body_exited(_body):
	$Jiraya/Dialogue/ColorRect/whatsapp.stop()
	$Jiraya/AnimatedSprite.play("jranafire")
	get_parent().get_node("Dialogue").visible = false
	#$pst.play()

func _on_Timer2_timeout():
	#$pst.play()
	pass
func stop_music():
	$pst.stop()
