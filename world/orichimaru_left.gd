extends KinematicBody2D

var dead   = false
const EnemyDeathEffect = preload("res://Effects/OrochimaruDeathEffect.tscn")
export var HEALTH  = 4
export var FRICTION = 200
onready var hurtbox  = $HurtBox
onready var bar  = $Health/Bar

func _on_attack_body_entered(body):
	$AnimatedSprite.play("right")

func _on_attack_body_exited(body):
	$AnimatedSprite.stop()
	
func flip_right():
	$AnimatedSprite.flip_h = true
	$AnimatedSprite.animation = "right"

func _on_Hurtbox_area_entered(area):
	if HEALTH != 1:
		$hit.play()
		bar.rect_size.x = bar.rect_size.x - (bar.rect_size.x / HEALTH)
		HEALTH = HEALTH -1
	else:
		$deathsound.play()
		dead = true
		var enemyDeathEffect = EnemyDeathEffect.instance()
		get_parent().add_child(enemyDeathEffect)
		enemyDeathEffect.global_position = $death.global_position
		queue_free()


