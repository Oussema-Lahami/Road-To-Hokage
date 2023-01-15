extends KinematicBody2D

#const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")
const tobideath = preload("res://Effects/DanzoDeathEffect.tscn")
var speed = 170
var motion = Vector2.ZERO
var player = null
var attack = false
var dead   = false
export var HEALTH  = 5
export var FRICTION = 200
onready var hurtbox  = $HurtBox
onready var bar  = $Health/Bar

func _physics_process(delta):

	motion = Vector2.ZERO
	if player && !attack :
		$AnimatedSprite.play("run")
		motion = position.direction_to(player.position) * speed
	elif attack:
		$AnimatedSprite.play("attack3") 
		motion = position.direction_to(player.position) * speed
	elif player == null:
		$AnimatedSprite.play("idle")
	$AnimatedSprite.flip_h = motion.x < 0
func flip_right():
	$AnimatedSprite.flip_h = true
func _on_attack_body_entered(body):
	player = body

func _on_attack_body_exited(body):
	player = null
	
func _on_jump_body_entered(body):
	attack = true
	
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
		enemyDeathEffect.global_position = $Position2D.global_position
		queue_free()

