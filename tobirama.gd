extends KinematicBody2D

var speed = 120
var motion = Vector2.ZERO
var player = null
var attack = false


func _physics_process(delta):
	motion = Vector2.ZERO
	if player && !attack :
		$AnimatedSprite.play("run")
		motion = position.direction_to(player.position) * speed
	elif attack:
		$AnimatedSprite.play("attack")
		motion = position.direction_to(player.position) * speed
	elif player == null:
		$AnimatedSprite.play("idle")
	motion = move_and_slide(motion)
	$AnimatedSprite.flip_h = motion.x < 0


func _on_attack_body_entered(body):
	player = body


func _on_attack_body_exited(body):
	player = null


func _on_jump_body_entered(body):
	attack = true


func _on_jump_body_exited(body):
	attack = false


func _on_Hurtbox_area_entered(area):
	queue_free()
