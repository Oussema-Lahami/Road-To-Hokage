extends Control


onready var health_over = $ChakraOver

func _on_health_updated(health , amount):
	health_over.value = health


func _on_max_health_updated(max_health):
	health_over.max_value = max_health


func _on_Timer_timeout():
	_on_health_updated(health_over.value - 5 , 5)
