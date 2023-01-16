extends Control

var selected_menu = 0

func _process(delta):
	#if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_cancel"):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://UI/FirstMenu.tscn")

func change_menu_color():
	$New.color    = Color.gray
	$MainMenu.color   = Color.gray
	$Quit.color   = Color.gray
	
	match selected_menu:
		0:
			$New.color  = Color.greenyellow
		1:
			$MainMenu.color = Color.greenyellow
		2:
			$Quit.color = Color.greenyellow

func _ready():
	change_menu_color()
	
func _input(_event):
	if Input.is_action_just_pressed("ui_down"):
		selected_menu = (selected_menu + 1) % 3;
		change_menu_color()
	elif Input.is_action_just_pressed("ui_up"):
		if selected_menu > 0:
			selected_menu = selected_menu - 1
		else:
			selected_menu = 2
		change_menu_color()

	elif Input.is_action_just_pressed("ui_attack") or Input.is_action_just_pressed("ui_accept"):
		match selected_menu:
			0:
				# New game
# warning-ignore:return_value_discarded
				SceneTransition.change_scene("res://Levels/Level1.tscn")
				#get_tree().change_scene("res://Levels/Level1.tscn")
			1:
				# Main Menu
				SceneTransition.change_scene("res://UI/FirstMenu.tscn")
			2:
				# Quit game
				get_tree().quit()
