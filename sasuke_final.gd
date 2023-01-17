extends KinematicBody2D

#const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")
const tobideath = preload("res://Effects/TobiramaDeathEffect.tscn")
var speed = 120
var motion = Vector2.ZERO
var knockback = Vector2.ZERO
var player = null
var attack = false
var dead   = false
var shoot = false
var KATON = preload("res://katon.tscn")
#var do_damage= $Hitbox.CollisionShape2D.set_enabled(True)
export var HEALTH  = 5
export var FRICTION = 200
onready var hurtbox  = $HurtBox
onready var bar  = $Health/Bar
onready var playerDetectionZone = $PlayerDetectionZone


func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	motion = Vector2.ZERO
	if shoot && !player && !attack:
		$AudioStreamPlayer2D.play()
		$Timer.start()
	elif player && !attack && !shoot :
		$AnimatedSprite.play("run")
		motion = position.direction_to(player.position) * speed
	elif attack:
		$AnimatedSprite.play("attack1")
		motion = position.direction_to(player.position) * speed
	elif player == null:
		$AnimatedSprite.play("stance")
	elif dead:
		$AnimatedSprite.play("Fall")
	motion = move_and_slide(motion)
	$AnimatedSprite.flip_h = motion.x < 0

func _on_attack_body_entered(body):
	player = body

func _on_attack_body_exited(body):
	player = null

func _on_jump_body_entered(body):
	attack = true
	#$Hitbox.CollisionShape2D.set_enabled(true)

func _on_jump_body_exited(body):
	attack = false

func _on_Hurtbox_area_entered(area):
	if HEALTH != 1:
		$hit.play()
		bar.rect_size.x = bar.rect_size.x - (bar.rect_size.x / HEALTH)
		HEALTH = HEALTH -1
	else:
		$deathsound.play()
		dead = true
		var enemyDeathEffect = tobideath.instance()
		get_parent().add_child(enemyDeathEffect)
		enemyDeathEffect.global_position = global_position
		queue_free()


func _on_Hitbox_body_entered():
	pass # Replace with function body.


func _on_katon_body_entered(body):
	shoot = true


func _on_katon_body_exited(body):
	shoot = false


func _on_Timer_timeout():
	$AudioStreamPlayer2D.stop()
	$Timer.stop()
	$AnimatedSprite.play("katon")
	var katon = KATON.instance()
	if $AnimatedSprite.flip_h == true: 
		katon.set_katon_direction(Vector2(-1 , -1))
	get_parent().add_child(katon)
	katon.global_position = $Position2D.global_position
