extends KinematicBody2D

#const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")
const tobideath = preload("res://Effects/TobiramaDeathEffect.tscn")
var speed = 120
var motion = Vector2.ZERO
var knockback = Vector2.ZERO
var player = null
var attack = false
var dead   = false
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
	if player && !attack :
		$AnimatedSprite.play("run")
		motion = position.direction_to(player.position) * speed
	elif attack:
		$AnimatedSprite.play("attack3") 
		motion = position.direction_to(player.position) * speed
	elif player == null:
		$AnimatedSprite.play("idle")
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
