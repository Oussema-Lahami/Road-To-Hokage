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

func _ready():
	$AnimatedSprite.play("attack")

func flip_right():
	$AnimatedSprite.flip_h = true
func _on_attack_body_entered(body):
	$gumo.play()
	$AnimatedSprite.play("default")

func _on_attack_body_exited(body):
	$gumo.stop()
	$AnimatedSprite.play("attack")

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


func _on_Hurtbox_area_exited(area):
	pass # Replace with function body.
