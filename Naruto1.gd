extends KinematicBody2D

const MAX_SPEED = 170

const ACCELERATION = 1000
const FRICTION = 1000
var velocity = Vector2.ZERO
var direction = Vector2(1,0)
var attack = false
var dead   = false

export var HEALTH  = 100
onready var hurtbox  = $HurtBox
var secondForm = false
var thirdForm = false
var new = newForm.instance()
const SHURIKEN = preload("res://shuriken.tscn")
const newForm = preload("res://naruto2.tscn") 
const NARUTO3 = preload("res://naruto3.tscn")
const SMOKE = preload("res://smoke.tscn")
const Jiraya = preload("res://Jiraya.tscn")
const sage = preload("res://sageMode.tscn")
onready var bar  = $Health/Bar
var jiraya =Jiraya.instance()
var smoke = SMOKE.instance()
var throwtimer = 0
var naruto3 = NARUTO3.instance()
var sageN = sage.instance()
onready var label = $Health/Label


func _process(delta):
	label.text = str(HEALTH)+ " HP"
	if Input.is_action_just_pressed("throw") && !secondForm:
		$AnimatedSprite.play("throw")
	
	if throwtimer > 0:
		throwtimer -= delta


func _physics_process(delta):
	#player movement start
	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		$steps.play()
		$AnimatedSprite.play("right")
		$AnimatedSprite.flip_h = false
		if sign($Position2D.position.x) == -1:
			$Position2D.position.x *= -1
	elif Input.is_action_pressed("ui_left"):
		$steps.play()
		$AnimatedSprite.play("right")
		$AnimatedSprite.flip_h = true
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
	elif Input.is_action_pressed("ui_up"):
		$steps.play()
		$AnimatedSprite.play("up")
		if sign($Position2D.position.y) == -1:
			$Position2D.position.y *= -1
	elif Input.is_action_pressed("ui_down"):
		$steps.play()
		$AnimatedSprite.play("down")
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
	elif secondForm :
		$steps.stop()
		$AnimatedSprite.visible = false
	elif (not $AnimatedSprite.animation == "throw") or throwtimer <= 0:
		$steps.stop()
		$AnimatedSprite.play("stanceRight")


	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED , ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO , FRICTION * delta)
	
	velocity = move_and_slide(velocity)

	#throw shuriken option by pressing "C" 
	if Input.is_action_just_pressed("throw") and $AnimatedSprite.visible == true :
		$AnimatedSprite.play("throw")
		throwtimer = 0.1
		var shuriken = SHURIKEN.instance()
		$ShurikenSound.play()
		if $AnimatedSprite.flip_h == true: 
			shuriken.set_shuriken_direction(Vector2(-1 , -1))
		if Input.is_action_pressed("ui_up"):
			shuriken.set_shuriken_direction(Vector2(1,2))
			#shuriken.up = true
			#shuriken.down = false
		if Input.is_action_pressed("ui_down"):
			shuriken.set_shuriken_direction(Vector2(-1,-2))
			#shuriken.up = true
			#shuriken.down = true
		get_parent().add_child(shuriken)
		shuriken.global_position = $Position2D.global_position
	# option to transform into second form animation by pressing "X"
	
	if Input.is_action_just_pressed("transform") && !secondForm && !thirdForm :
		if !naruto3.visible:
			naruto3.visible = true
		if HEALTH <80 :
			HEALTH=HEALTH+20
		else:
			HEALTH=100
		add_child(smoke)
		smoke.get_node("Position2D").position = $Position2D2.position
		smoke.set_z_index(1000)
		smoke.play()
		$SmokeSound.play()
		#new.get_node("Camera2D").starting()
		secondForm = true
		thirdForm = false
		$AnimatedSprite.visible = false
		$healthBar.visible = false
		if $AnimatedSprite.flip_h == true: 
			new.set_form_direction()
		get_parent().add_child(new)
		new.global_position = $Position2D2.global_position
		$Timer.start()
		
	# option to transform into second form animation by pressing "F"
	if Input.is_action_just_pressed("sage") && !thirdForm && !secondForm:
		if !sageN.visible:
			sageN.visible = true
		if HEALTH <80 :
			HEALTH=HEALTH+20
		else:
			HEALTH=100
		add_child(smoke)
		smoke.get_node("Position2D").position = $Position2D2.position
		smoke.set_z_index(1000)
		smoke.play()
		$SmokeSound.play()
		thirdForm = true
		$AnimatedSprite.visible = false
		$healthBar.visible = false
		$Timer2.start()




	# option to go back to first form after transforming by pressing "Q"
	if (Input.is_action_just_pressed("goBack") && (secondForm || thirdForm)):
		#HEALTH=10 
		add_child(smoke)
		smoke.get_node("Position2D").position = $Position2D2.position
		smoke.set_z_index(1000)
		smoke.play()
		$SmokeSound.play()
		get_node("Camera2D").starting()
		secondForm = false
		thirdForm = false
		$AnimatedSprite.visible = true
		$CollisionShape2D.disabled = false
		$Camera2D.current = true
		$Position2D2.global_position = naruto3.global_position
		naruto3.visible = false
		sageN.visible = false

	# going back when running out of chakra
	if naruto3.get_node("chakraBar/ChakraOver").value == 0 && secondForm:
		add_child(smoke)
		smoke.get_node("Position2D").position = $Position2D2.position
		smoke.set_z_index(1000)
		smoke.play()
		get_node("Camera2D").starting()
		secondForm = false
		$AnimatedSprite.visible = true
		$CollisionShape2D.disabled = false
		$Camera2D.current = true
		$Position2D2.global_position = naruto3.global_position
		naruto3.visible = false


func _on_Timer_timeout():
	new.delete()
	$Timer.stop()
	if $AnimatedSprite.flip_h == true:
		naruto3.flip()
	get_parent().add_child(naruto3)
	naruto3.global_position = $Position2D2.global_position

func _on_Timer2_timeout():
	$Timer2.stop()
	if $AnimatedSprite.flip_h == true:
		sage.flip()
	get_parent().add_child(sageN)
	sageN.global_position = $Position2D.global_position


func _on_Hurtbox_area_entered(area):
	if area.name == "katon": 
		if HEALTH > 20:
			HEALTH = HEALTH - 20
			bar.rect_size.x = bar.rect_size.x - (bar.rect_size.x / (HEALTH/10))
			$Hurt.play()
			#var duration = 1
			#var amplitude = 100
			#shake_camera(0.3,10)

		elif HEALTH <= 20:
			dead = true
			dying_state()

	if area.name == "firejiraya": 
		if HEALTH > 40:
			HEALTH = HEALTH - 40
			bar.rect_size.x = bar.rect_size.x - (bar.rect_size.x / (HEALTH/10))
			$Hurt.play()
		elif HEALTH <= 40:
			dead = true
			dying_state()
		#yield(shake_camera(0.3, 10), "tween_completed")
	elif HEALTH != 10:
		bar.rect_size.x = bar.rect_size.x - (bar.rect_size.x / HEALTH*10)
		$Hurt.play()
		HEALTH = HEALTH - 10
		#yield(shake_camera(0.3, 10), "tween_completed")
	else:
		dead = true
		dying_state()

func dying_state(): 
	#$HurtBox.queue_free()
	Global.stop_music()
	Global.death_play()
	get_tree().change_scene("res://UI/game-over.tscn")

func shake_camera(duration, amplitude):
	var cam_tween = Tween.new()
	cam_tween.interpolate_property($Camera2D, "offset", Vector2.ZERO, Vector2(rand_range(-amplitude, amplitude), rand_range(-amplitude, amplitude)), duration, Tween.TRANS_SINE, Tween.EASE_OUT)
	cam_tween.start()
	yield(cam_tween, "tween_completed")
	$Camera2D.offset = Vector2.ZERO
	


func _on_Final_Battle_body_entered():
	pass # Replace with function body.
