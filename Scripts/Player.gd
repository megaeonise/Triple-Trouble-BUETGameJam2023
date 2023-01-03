extends KinematicBody2D
#Variables
var speed: int = 400
var jumpspeed: int = -200
var gravity: int = 400
var velocity = Vector2()

#Controls
func get_input(delta):
	#initial velocity
	velocity.x = 0
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
