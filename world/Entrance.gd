extends Area2D

# warning-ignore:unused_argument
func _on_Entrance_body_entered(body):
	Global.direction = body.roll_vector
	Global.from = get_parent().name
	#print("Came from " + Global.from, " and go to " + Global.from + "Pos" + " on " + self.name + " Level")
# warning-ignore:return_value_discarded
	#get_tree().change_scene(("res://Levels/") + (self.name) + (".tscn"))
	#get_tree().change_scene("res://UI/FirstMenu.tscn")
