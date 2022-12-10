extends KinematicBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4
export var HEALTH = 3

enum{
	IDLE ,
	WANDER ,
	CHASE
}


var state = IDLE
var velocity = Vector2.ZERO

onready var playerDetectionZone = $PlayerDetectionZone
onready var stats = $Stats
onready var sprite = $AnimatedSprite

func _physics_process(delta):
	match state:
			
			IDLE:
				velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			WANDER:
				pass
			CHASE:
				var player = playerDetectionZone.player
				if player != null:
					accelerate_towards_point(player.global_position, delta)
				else:
					state = IDLE
					
	velocity = move_and_slide(velocity)
	

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0
