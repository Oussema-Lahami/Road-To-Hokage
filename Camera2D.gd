extends Camera2D

# Variables for the shake effect
var amplitude = 100
var duration = 1.8
var time_passed = 0
export var start = false

# Store the camera's original position
var original_position

func _ready():
	original_position = position

# Start the shake
func start_shake(amplitude, duration):
	time_passed = 0
	self.amplitude = amplitude
	self.duration = duration
	self.position = original_position
	
func starting():
	start = true

# Update the shake every frame
func _process(delta):
	if time_passed < duration && start:
		# Add a random offset to the camera's position
		var offset = Vector2(
			rand_range(-amplitude, amplitude),
			rand_range(-amplitude, amplitude)
		)
		self.position = original_position + offset
		time_passed += delta
	else:
		# Reset the camera's position when the shake is finished
		self.position = original_position
