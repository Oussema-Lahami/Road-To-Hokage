extends AnimatedSprite

func _ready():
# warning-ignore:return_value_discarded
	self.connect("animation_finished", self, "_on_animation_finished")
	play("Animate")
	$Imposter_Killed.play()

func _on_animation_finished():
	queue_free()
