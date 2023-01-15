extends KinematicBody2D

const MAX_SPEED = 170
const ACCELERATION = 1000
const FRICTION = 1000
var velocity = Vector2.ZERO
var RASENGAN = preload("res://rasengan.tscn")

func _process(delta):
		#throw a punch with the button "R"
	if Input.is_action_pressed("rasengan"):
		$AnimatedSprite.play("rasengan")
		$Timer.start()
		$Timer2.start()
		$rasengansound.play()

func _physics_process(delta):
	#player movement start
	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite.play("move")
		$AnimatedSprite.flip_h = false
		if sign($Position2D.position.x) == -1:
			$Position2D.position.x *= -1
	elif Input.is_action_pressed("ui_left"):
		$AnimatedSprite.play("move")
		$AnimatedSprite.flip_h = true
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
	elif Input.is_action_pressed("ui_up"):
		$AnimatedSprite.play("move")
		if sign($Position2D.position.y) == -1:
			$Position2D.position.y *= -1
	elif Input.is_action_pressed("ui_down"):
		$AnimatedSprite.play("move")
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
	elif !Input.is_action_pressed("rasengan") :
		$AnimatedSprite.play("stance")



	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED , ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO , FRICTION * delta)
	
	velocity = move_and_slide(velocity)
	
func flip():
	$AnimatedSprite.flip_h = true


func _on_Timer_timeout():
	$Timer.stop()
	var rasengan = RASENGAN.instance()
	if $AnimatedSprite.flip_h == true: 
		rasengan.set_rasengan_direction(Vector2(-1 , -1))
	if Input.is_action_pressed("ui_up"):
		rasengan.set_rasengan_direction(Vector2(1,2))
	if Input.is_action_pressed("ui_down"):
		rasengan.set_rasengan_direction(Vector2(-1,-2))
	get_parent().add_child(rasengan)
	rasengan.global_position = $Position2D2.global_position


func _on_Timer2_timeout():
	$rasengansound.stop()
