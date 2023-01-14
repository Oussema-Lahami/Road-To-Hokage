extends KinematicBody2D

const tobideath = preload("res://Effects/JirayaDeathEffect.tscn")
const jiraya2 = preload("res://tobirama.tscn")
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

func _ready():
	#$AnimatedSprite.play("idle")
	pass
func _on_attack_body_entered(body):
	$AnimatedSprite.play("attack")
		
func _on_attack_body_exited(body):
	$AnimatedSprite.stop()

func _on_Hurtbox_area_entered(area):
	if HEALTH != 1:
		$hit.play()
		bar.rect_size.x = bar.rect_size.x - (bar.rect_size.x / HEALTH)
		HEALTH = HEALTH -1
		#knockback = area.knockback_vector * 120
		#hurtbox.create_hit_effect()
		#hurtbox.start_invincibility(0.4)
	else:
		$deathsound.play()
		dead = true
		var enemyDeathEffect = tobideath.instance()
		get_parent().add_child(enemyDeathEffect)
		enemyDeathEffect.global_position = global_position
		queue_free()
		#$AnimatedSprite.visible=false
		#var jir = jiraya2.instance()


func _on_Hurtbox_area_exited(area):
	pass # Replace with function body.
