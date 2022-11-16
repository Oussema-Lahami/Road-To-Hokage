extends KinematicBody2D

const MAX_SPEED = 250
const ACCELERATION = 1000
const FRICTION = 1000
var velocity = Vector2.ZERO

var direction = Vector2(1,0)
var secondForm = 0
var new = newForm.instance()
const SHURIKEN = preload("res://shuriken.tscn")
const newForm = preload("res://naruto2.tscn")
const NARUTO3 = preload("res://naruto3.tscn")

func _process(delta):
	if Input.is_action_pressed("throw") && secondForm < 1:
		$AnimatedSprite.play("throw")
	

func _physics_process(delta):
	#player movement start
	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite.play("right")
		$AnimatedSprite.flip_h = false
		if sign($Position2D.position.x) == -1:
			$Position2D.position.x *= -1
	elif Input.is_action_pressed("ui_left"):
		$AnimatedSprite.play("right")
		$AnimatedSprite.flip_h = true
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
	elif Input.is_action_pressed("ui_up"):
		$AnimatedSprite.play("up")
		if sign($Position2D.position.y) == -1:
			$Position2D.position.y *= -1
	elif Input.is_action_pressed("ui_down"):
		$AnimatedSprite.play("down")
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
	elif secondForm == 1 :
		$AnimatedSprite.visible = false
	else :
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
	if Input.is_action_just_pressed("throw"):
		$AnimatedSprite.play("throw")
		var shuriken = SHURIKEN.instance()
		if $AnimatedSprite.flip_h == true: 
			shuriken.set_shuriken_direction(-1)
		get_parent().add_child(shuriken)
		shuriken.global_position = $Position2D.global_position
	# option to transform into second form animation by pressing "X"
	if Input.is_action_just_pressed("transform") && secondForm < 1:
		secondForm = 1
		$AnimatedSprite.visible = false
		if $AnimatedSprite.flip_h == true: 
			new.set_form_direction()
		get_parent().add_child(new)
		new.global_position = $Position2D2.global_position
		$Timer.start()


func _on_Timer_timeout():
	new.delete()
	$Timer.stop()
	var naruto3 = NARUTO3.instance()
	if $AnimatedSprite.flip_h == true:
		naruto3.flip()
	get_parent().add_child(naruto3)
	naruto3.global_position = $Position2D2.global_position
