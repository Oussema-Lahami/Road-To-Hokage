extends Area2D

var speed = 700
var direction = Vector2(1 , -1)
var up = false
var down = false

func set_shuriken_direction(dir):
	direction = dir

func _physics_process(delta):
	if up:
		$AnimatedSprite.play("default")
		position += transform.y * speed * delta * direction.x
	elif down:
		$AnimatedSprite.play("default")
		position += transform.y * speed * delta * direction
	else : 
		$AnimatedSprite.play("default")
		position += transform.x * speed * delta * direction.x


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()

