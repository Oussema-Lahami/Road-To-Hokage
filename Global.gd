extends Node

var direction        = Vector2.ZERO
var player           = "Player"
var visited          = ["Level1"]
var map              = "empty"
var timer
var data
var current_level

signal no_health
signal health_changed(value)
signal max_health_changed(value)
signal health_bar_size(value)
signal update_status

func death_play():
	$Death.play()

func play_music():
	$Music.play()
	
func stop_music():
	$Music.stop()

func save_game():
	data = {
		"current_level"    : current_level,
		"direction"        : [direction.x, direction.y],
		"player"           : player,
		"visited"          : visited,
		"map"              : map,
}
	var file = File.new()
	file.open("user://savegame.json", File.WRITE)
	var json = to_json(data)
	file.store_line(json)
	file.close()
func load_game():
	var file = File.new()
	if file.file_exists("user://savegame.json"):
		file.open("user://savegame.json", File.READ)
		data = parse_json(file.get_as_text())
		file.close()

func reset():

	stop_music()
	direction        = Vector2.ZERO
	player           = "Player"
	visited          = ["Level1"]
	get_tree().change_scene("res://UI/FirstMenu.tscn")
