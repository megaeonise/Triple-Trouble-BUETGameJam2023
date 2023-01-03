extends KinematicBody2D
#Variables
var speed: int = 50
var jumpspeed: int = -25
var gravity: int = 50
var velocity = Vector2()
var states: Array = ['Ground', 'Air', 'Dash', 'Interact', 'Death']
var state: String = states[0]
#Signals
signal Ground
signal Right
signal Left
signal Right_GDash
signal Right_ADash
signal Left_GDash
signal Left_ADash
signal Air
signal Stop
signal Jump

#Controls
func get_input(delta):
	#Initial Velocity
	velocity.x = 0
	if is_on_floor():
		state = states[0]
		emit_signal('Ground')
	if not state in states.slice(2,4):
		#Moving
		#Jump
		if Input.is_action_just_pressed("jump") and state == states[0]:
			state = states[1]
			velocity.y+=jumpspeed
			emit_signal('Jump')
			emit_signal('Air')
		#Right Move
		if Input.is_action_pressed("move_right"):
			velocity.x += speed
			emit_signal('Right')
		#Left Move
		elif Input.is_action_pressed("move_left"):
			velocity.x -= speed
			emit_signal('Left')
		#Stop Signal
		else:
			emit_signal("Stop")
		#Right Dash
		if Input.is_action_just_pressed("dash") and Input.is_action_pressed('move_right'):
			#Right Ground Dash
			if state == states[0]:
				print('rdash')
				state = states[2]
				emit_signal('Right_GDash')
				velocity.x += speed*2.5
				state = states[0]
				emit_signal('Ground')
			#Right Air Dash
			else:
				print('rudash')
				state = states[2]
				emit_signal('Right_ADash')
				velocity.y = 0
				velocity.x = 0
				velocity.x += speed*2.5
				state = states[1]
				emit_signal('Air')
		#Left Dash
		if Input.is_action_just_pressed("dash") and Input.is_action_pressed('move_left'):
			#Left Ground Dash
			if state == states[0]:
				print('ldash')
				emit_signal('Light_GDash')
				state = states[2]
				velocity.x -= speed*2.5
				state = states[0]
				emit_signal('Ground')
			#Left Air Dash
			else:
				print('ludash')
				state = states[2]
				emit_signal('Left_ADash')
				velocity.y = 0
				velocity.x = 0
				velocity.x -= speed*2.5
				state = states[1]
				emit_signal('Air')
		
	#Gravity
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
#Driver code
func _physics_process(delta):
	get_input(delta)

