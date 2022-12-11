extends KinematicBody2D

var speed = 150
var motion = Vector2.ZERO
var player = null


func _physics_process(delta):
	motion = Vector2.ZERO
	if player :
		$AnimatedSprite.play("run")
		motion = position.direction_to(player.position) * speed
	elif player == null:
		$AnimatedSprite.play("idle")
	motion = move_and_slide(motion)


func _on_attack_body_entered(body):
	player = body


func _on_attack_body_exited(body):
	player = null
