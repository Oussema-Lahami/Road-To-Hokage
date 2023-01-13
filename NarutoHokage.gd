extends KinematicBody2D

var speed = 100
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


func _physics_process(delta):
	#knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	#knockback = move_and_slide(knockback)
	motion = Vector2.ZERO
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
extends KinematicBody2D

var speed = 100
var motion = Vector2.ZERO
var knockback = Vector2.ZERO
var player = null
var attack = false
var dead   = false
var walk = true
var attack_distance = 150 #distance at which AI will start running
export var HEALTH  = 5
export var FRICTION = 200
onready var hurtbox  = $HurtBox
onready var bar  = $Health/Bar
onready var playerDetectionZone = $PlayerDetectionZone

func _physics_process(delta):
	motion = Vector2.ZERO
	if player:
		distance = position.distance_to(player.position)
		if distance > attack_distance:
			$AnimatedSprite.play("run")
			motion = position.direction_to(player.position) * speed
		else:
			$AnimatedSprite.play("walk")
			motion = position.direction_to(player.position) * (speed/2)
			
		motion = move_and_slide(motion)
		$AnimatedSprite.flip_h = motion.x < 0
	else:
		$AnimatedSprite.play("idle")

func _on_attack_body_entered(body):
	player = body

func _on_attack_body_exited(body):
	player = null

func _on_Hurtbox_area_entered(area):
	queue_free()
"""


func _on_AnimatedSprite_animation_finished():
	pass # Replace with function body.
