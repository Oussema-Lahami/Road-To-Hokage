extends Node

export(int) var max_health = 5 setget set_max_health
var health           = max_health setget set_health
var health_bar       = 0 setget set_health_bar

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

###################################################################
func _ready():
	self.health = max_health

######################################################## Health ###
func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")

func set_health_bar(value):
	health_bar = value
	emit_signal("health_bar_size", health_bar)

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
		"max_health"       : max_health,
		"health"           : health,
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
	max_health       = 5
	health           = max_health
	player           = "Player"
	visited          = ["Level1"]
	get_tree().change_scene("res://UI/FirstMenu.tscn")
