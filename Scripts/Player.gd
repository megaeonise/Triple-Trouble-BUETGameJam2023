extends KinematicBody2D
#Variables
var speed: int = 400
var jumpspeed: int = -200
var gravity: int = 400
var velocity = Vector2()
var states: Array = ['Ground', 'Air', 'Dash', 'Interact', 'Death']
var state: String = states[0]

#Controls
func get_input(delta):
	#initial velocity
	velocity.x = 0
	if not state in states.slice(2,4):
		print('it works')
		#Right Move
		if Input.is_action_pressed("move_right"):
			velocity.x += speed
		#Left Move
		if Input.is_action_pressed("move_left"):
			velocity.x -= speed
		#Right Dash
		if Input.is_action_just_pressed("dash")  and Input.is_action_pressed('move_right'):
			if state == states[0]:
				print('rdash')
				state = states[2]
				velocity.x += speed*2.5
				state = states[0]
			else:
				print('rudash')
				state = states[2]
				velocity.x += speed*2.5
				state = states[1]
		#Left Dash
		if Input.is_action_just_pressed("dash") and Input.is_action_pressed('move_left'):
			if state == states[0]:
				print('ldash')
				state = states[2]
				velocity.x -= speed*2.5
				state = states[0]
			else:
				print('ludash')
				state = states[2]
				velocity.x -= speed*2.5
				state = states[1]
	#Gravity and Friction
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func _physics_process(delta):
	get_input(delta)

