extends Area2D

var speed = 300
var direction = 1

func set_katon_direction(dir):
	direction = dir

	
func _physics_process(delta):
	$AnimatedSprite.play("default")
	position += transform.x * speed * delta * direction


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
