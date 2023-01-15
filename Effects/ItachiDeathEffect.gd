extends AnimatedSprite

var x = 0

func _ready():
	self.connect("animation_finished", self, "_on_animation_finished")
	play("Animate")

func _on_animation_finished():
	queue_free()
