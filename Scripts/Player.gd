extends KinematicBody2D
#Variables
var speed: int = 300
var jumpspeed: int = -150
var gravity: int = 300
var velocity = Vector2()
var states: Array = ['Ground', 'Air', 'Dash', 'Interact', 'Death', 'Blob']
var state: String = states[0]
var finished: bool = false
var facing: bool = false
var breaker: bool = false
#Signals
signal Ground
signal Right
signal Left
signal Right_Dash
signal Left_Dash
signal Air
signal Stop
signal Jump
signal Interact(breaker)
signal Block(x, y)
signal Direction(facing)

#Controls
func get_input(delta):
	#Initial Velocity
	velocity.x = 0
	#Setting Ground state after returning from Air
	if is_on_floor() and state == states[1] and not state in states.slice(2,5):
		state = states[0]
		emit_signal('Ground')
		$AnimatedSprite.visible = true
	#Setting Air state after falling
	if is_on_floor()!=true and not state in states.slice(2,5):
		state = states[1]
		emit_signal('Air')
		$AnimatedSprite.visible = true
	if state == states[5]:
		gravity = 0
		velocity.x = 0
		velocity.y = 0
		$AnimatedSprite.visible = false
		if Input.is_action_just_pressed("move_left"):
			velocity.x-= speed+500*10
			state = states[1]
			gravity = 300
			$AnimatedSprite.visible = true
		elif Input.is_action_just_pressed("move_right"):
			velocity.x+= speed+500*10
			state = states[1]
			gravity = 300
			$AnimatedSprite.visible = true
		elif Input.is_action_just_pressed("jump"):
			velocity.y -= speed*5
			state = states[1]
			gravity = 300
			$AnimatedSprite.visible = true
	if not state in states.slice(2,5):
		#Moving
		#Jump
		if Input.is_action_just_pressed("jump") and state == states[0]:
			state = states[1]
			velocity.y+=jumpspeed
			emit_signal('Jump')
			emit_signal('Air')
		#Right Move
		if Input.is_action_pressed("move_right"):
			facing = false
			velocity.x += speed
			emit_signal('Right')
		#Left Move
		elif Input.is_action_pressed("move_left"):
			facing = true
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
				emit_signal('Right_Dash')
				velocity.x = 0
				velocity.x += 2500

			#Right Air Dash
			else:
				print('rudash')
				state = states[2]
				emit_signal('Right_Dash')
				velocity.x = 0
				velocity.x += 2500
		
		#Left Dash
		if Input.is_action_just_pressed("dash") and Input.is_action_pressed('move_left'):
			#Left Ground Dash
			if state == states[0]:
				state = states[2]
				print('ldash')
				emit_signal('Left_Dash')
				state = states[2]
				velocity.x = 0
				velocity.x -= 2500
			#Left Air Dash
			else:
				print('ludash')
				state = states[2]
				emit_signal('Left_Dash')
				velocity.x = 0
				velocity.x -= 2500
		#Interact
		if Input.is_action_just_pressed("interact"):
			finished = false
			state = states[3]
			emit_signal('Interact', breaker)
			if breaker:
				breaker = false
	
	#Gravity
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
#Driver code
func _physics_process(delta):
	get_input(delta)
	#Math
	emit_signal("Block", position.x, position.y)
	emit_signal('Direction', facing)
	print(state)

func _on_AnimatedSprite_animation_finished():
	if is_on_floor():
		state = states[0]
		emit_signal("Ground")
	else:
		state = states[1]
		emit_signal("Air")


func _on_DarkMatter_body_entered(body):
	state = states[5]


func _on_Breaker_body_entered(body):
	breaker = true
	
