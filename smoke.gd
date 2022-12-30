extends Area2D



func play():
	$Timer.start()
	$AnimatedSprite.visible = true
	$AnimatedSprite.play("default")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	$AnimatedSprite.playing = false
	$AnimatedSprite.visible = false
