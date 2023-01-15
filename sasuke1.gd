extends KinematicBody2D

const tobideath = preload("res://Effects/TobiramaDeathEffect.tscn")
export var HEALTH  = 25
onready var hurtbox  = $HurtBox
onready var bar  = $Health/Bar
var dead   = false

func _ready():
	pass # Replace with function body.


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
		SceneTransition.change_scene("res://UI/winning-gam.tscn")
