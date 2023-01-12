extends AnimatedSprite

var x = 0

func _ready():
	randomize()
	x = randi()%2+1
	self.connect("animation_finished", self, "_on_animation_finished")
	if x==1 :
		play("Animate")
	else :
		play("Animate2")

func _on_animation_finished():
	queue_free()
