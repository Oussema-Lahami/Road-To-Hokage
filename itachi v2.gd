extends KinematicBody2D
var KATON = preload("res://katon.tscn")
const tobideath = preload("res://Effects/ItachiDeathEffect.tscn")
var dead   = false
export var HEALTH  = 10
export var FRICTION = 200
onready var hurtbox  = $HurtBox
onready var bar  = $Health/Bar

func _ready():
	$AnimatedSprite.play("stance")

func _on_shoot_timeout():
	var katon = KATON.instance()
	if $AnimatedSprite.flip_h == true: 
		katon.set_katon_direction(Vector2(-1 , -1))
	get_parent().add_child(katon)
	katon.global_position = $Position2D.global_position
	$AnimatedSprite.play("stance")


func _on_attack2_area_entered(area):
		$katon.play()
		$katonStop.start()
		$AnimatedSprite.play("katon")
		$shoot.start()

func _on_attack2_area_exited(area):
	$AnimatedSprite.play("stance")

func _on_katonStop_timeout():
	$katon.stop()

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
		enemyDeathEffect.global_position = $Position2D2.global_position
		queue_free()
