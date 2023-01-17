extends KinematicBody2D

var speed = 145
var motion = Vector2.ZERO
var knockback = Vector2.ZERO
var player = null
var attack = false
var dead   = false
var walk = true
#var do_damage= $Hitbox.CollisionShape2D.set_enabled(True)
export var HEALTH  = 5
export var FRICTION = 200
onready var hurtbox  = $HurtBox
onready var bar  = $Health/Bar
onready var playerDetectionZone = $PlayerDetectionZone
var counter = 0

func _physics_process(delta):
	#if Input.is_ac
	#$AnimatedSprite.play("stance")
	if Input.is_action_pressed("ui_up"):
		motion.y = -100
		if player && !walk :
			$AnimatedSprite.play("run")
		elif walk && player:
			$AnimatedSprite.play("walk")
	if Input.is_action_pressed("ui_right"):
		if player:
			if position.distance_to(player.position) > 0:
				motion.x = 20
				$AnimatedSprite.play("run")
			else:
				motion.x = -speed
				$AnimatedSprite.play("walk")
		else:
			motion.x = 0
			$AnimatedSprite.play("idle")
	elif Input.is_action_pressed("ui_left"):
		motion.x=-100
		if player && !walk :
			$AnimatedSprite.play("run")
		elif walk && player:
			$AnimatedSprite.play("walk")
	else:
		motion.y = 0
		if player && !walk :
			$AnimatedSprite.play("run")
			motion = position.direction_to(player.position) * speed
		elif walk && player:
			$AnimatedSprite.play("walk")
			motion = position.direction_to(player.position) * (speed/2)
		elif player == null: # ki tabda b3id alih
			$AnimatedSprite.play("idle")
	motion = move_and_slide(motion)
	$AnimatedSprite.flip_h = motion.x < 0


func _on_attack_body_entered(body): #runtoplayer=attack
	player = body

func _on_attack_body_exited(body):
	player = body

func _on_jump_body_entered(body):   #walk=jump
	walk = true

func _on_jump_body_exited(body):
	walk= false

func _on_Hurtbox_area_entered(area):
		queue_free()
		
"""
3tahouli el chatbot 

"""


func _on_AnimatedSprite_animation_finished():
	pass # Replace with function body.
