extends CanvasLayer

func _show_name():
	$AnimationPlayer.play("ShowName")
	yield( $AnimationPlayer, "animation_finished" )
	queue_free()

func _ready():
	if get_parent().name == "Level1":
		$Label.text = "Welcome To Fushū Land"
		_show_name()
	elif get_parent().name == "Level2":
		$Label.text = "Welcome To Dotō Desert"
		_show_name()
