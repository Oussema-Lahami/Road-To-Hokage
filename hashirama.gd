extends KinematicBody2D
var DRAGON = preload("res://dragon.tscn")
const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")
export var HEALTH  = 3
var dead   = false
var dragon_dead = false
var attack = false 
var dragon = DRAGON.instance()
onready var hurtbox  = $HurtBox
onready var bar  = $Health/Bar
onready var playerDetectionZone = $PlayerDetectionZone

func _on_Timer_timeout():
	if $AnimatedSprite.flip_h == true: 
		dragon.flip()
		get_parent().add_child(dragon)
		dragon.global_position = $Position2D2.global_position
		dragon.play()
	else :
		get_parent().add_child(dragon)
		dragon.global_position = $Position2D.global_position
		dragon.play()

func _on_attack_body_entered(body):
	$Timer.start()
	$AnimatedSprite.play("default")

func _on_attack_body_exited(body):
	dragon.reset()
	$AnimatedSprite.play("idle")


func _on_Hurtbox_area_entered(area):
	if HEALTH != 1:
		#$hit.play()
		bar.rect_size.x = bar.rect_size.x - (bar.rect_size.x / HEALTH)
		HEALTH = HEALTH -1
	else:
		dead = true
		#dragon_dead = true
		#dragon.queue_free()
		var enemyDeathEffect = EnemyDeathEffect.instance()
		get_parent().add_child(enemyDeathEffect)
		enemyDeathEffect.global_position = $death.global_position
		queue_free()
