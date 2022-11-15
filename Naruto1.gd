extends KinematicBody2D

export var speed = 200
var direction = Vector2(1,0)
var velocity = Vector2.ZERO
var screen_size = Vector2.ZERO
const SHURIKEN = preload("res://shuriken.tscn")

func _process(delta):
	if Input.is_action_pressed("throw"):
		$AnimatedSprite.play("throw")

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite.play("right")
		$AnimatedSprite.flip_h = false
		velocity.x = speed
		if sign($Position2D.position.x) == -1:
			$Position2D.position.x *= -1
	elif Input.is_action_pressed("ui_left"):
		$AnimatedSprite.play("right")
		$AnimatedSprite.flip_h = true
		velocity.x = -speed
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
	elif Input.is_action_pressed("ui_up"):
		$AnimatedSprite.play("up")
		velocity.y = -speed
		if sign($Position2D.position.y) == -1:
			$Position2D.position.y *= -1
	elif Input.is_action_pressed("ui_down"):
		$AnimatedSprite.play("down")
		velocity.y = speed
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
	else :
		$AnimatedSprite.play("stanceRight")
		velocity.x = 0
		velocity.y = 0
		
		
	if Input.is_action_just_pressed("throw"):
		$AnimatedSprite.play("throw")
		var shuriken = SHURIKEN.instance()
		if $AnimatedSprite.flip_h == true: 
			shuriken.set_shuriken_direction(-1)
		get_parent().add_child(shuriken)
		shuriken.global_position = $Position2D.global_position
	velocity = move_and_slide(velocity)
