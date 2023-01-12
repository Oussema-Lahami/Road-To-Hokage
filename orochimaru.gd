extends KinematicBody2D

var dead   = false
#const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")
const EnemyDeathEffect = preload("res://Effects/OrochimaruDeathEffect.tscn")
export var HEALTH  = 3
export var FRICTION = 200
onready var hurtbox  = $HurtBox
onready var bar  = $Health/Bar
onready var playerDetectionZone = $PlayerDetectionZone

func _on_attack_body_entered(body):
	if $AnimatedSprite.animation == "right" :
		$AnimatedSprite.play("right")
	elif $AnimatedSprite.animation == "up" :
		$AnimatedSprite.play("up")
	else:
		$AnimatedSprite.play("down")


func _on_attack_body_exited(body):
	$AnimatedSprite.stop()
	
func flip_right():
	$AnimatedSprite.flip_h = true
	$AnimatedSprite.animation = "right"
	
func flip_up():
	$AnimatedSprite.animation = "up"

func _on_Hurtbox_area_entered(area):
	if HEALTH != 1:
		#$hit.play()
		bar.rect_size.x = bar.rect_size.x - (bar.rect_size.x / HEALTH)
		HEALTH = HEALTH -1
	else:
		dead = true
		#$EnemyDeathEffect.play("Animate")
		var enemyDeathEffect = EnemyDeathEffect.instance()
		get_parent().add_child(enemyDeathEffect)
		enemyDeathEffect.global_position = $death.global_position
		queue_free()
