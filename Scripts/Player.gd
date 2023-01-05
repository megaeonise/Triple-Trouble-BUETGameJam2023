extends KinematicBody2D
#Variables
var hp: int = 5
var speed: int = 300
var jumpspeed: int = -200
var gravity: int = 500
var velocity = Vector2()
var states: Array = ['Ground', 'Air', 'Dash', 'Interact', 'Death', 'Blob']
var state: String = states[0]
var finished: bool = false
var facing: bool = false
var breaker: bool = false
var floor_block: int = -1
var wall_block: int = -1
var invincibility: bool = false
var timer: bool = false
#Signals
signal Dead
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
		velocity.x = 0
		velocity.y = 0
		$AnimatedSprite.visible = false
		if Input.is_action_just_pressed("move_left"):
			velocity.x-= speed+500*10
			state = states[1]
			gravity = 500
			$AnimatedSprite.visible = true
		elif Input.is_action_just_pressed("move_right"):
			velocity.x+= speed+500*10
			state = states[1]
			gravity = 500
			$AnimatedSprite.visible = true
		elif Input.is_action_just_pressed("jump"):
			velocity.y -= speed*5
			state = states[1]
			gravity = 500
			$AnimatedSprite.visible = true
	if not state in states.slice(2,5):
		#Moving
		#Jump
		if Input.is_action_just_pressed("jump") and state == states[0]:
			state = states[1]
			velocity.y+=jumpspeed
			emit_signal('Jump')
			emit_signal('Air')
		if state==states[0]:
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
		elif state==states[1]:
			#Right Move
			if Input.is_action_pressed("move_right"):
				facing = false
				velocity.x += speed-200
				emit_signal('Right')
			#Left Move
			elif Input.is_action_pressed("move_left"):
				facing = true
				velocity.x -= speed-200
				emit_signal('Left')
			#Stop Signal
			else:
				emit_signal("Stop")
		#Right Dash
		if Input.is_action_just_pressed("dash") and Input.is_action_pressed('move_right'):
			#Right Ground Dash
			if state == states[0]:
				emit_signal('Right_Dash')
				velocity.x = 0
				velocity.x += 5000

			#Right Air Dash
			else:
				state = states[2]
				emit_signal('Right_Dash')
				velocity.x = 0
				velocity.x += 5000
		
		#Left Dash
		if Input.is_action_just_pressed("dash") and Input.is_action_pressed('move_left'):
			#Left Ground Dash
			if state == states[0]:
				emit_signal('Left_Dash')
				velocity.x = 0
				velocity.x -= 5000
			#Left Air Dash
			else:
				state = states[2]
				emit_signal('Left_Dash')
				velocity.x = 0
				velocity.x -= 5000
		#Interact
		if Input.is_action_just_pressed("interact"):
			finished = false
			state = states[3]
			emit_signal('Interact', false)
		if Input.is_action_just_pressed("destroy") and breaker==true:
			finished = false
			state = states[3]
			emit_signal('Interact', breaker)
			breaker = false
	
	#Gravity
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
#Driver code
func _physics_process(delta):
	get_input(delta)
	#Death
	if hp==0:
		state=states[4]
		emit_signal('Dead')
	#Damage
	if floor_block == 0 and invincibility == false and hp!=0:
		hp-=1
		invincibility = true
		$Timer.start()
	if finished == true and hp==0:
		hp = 5
		get_tree().reload_current_scene()
	#Bounce
	if floor_block == 2 and timer==false:
		timer=true
		$Timer.start()
		velocity.y -= 500
		print(velocity.y)
	#Icestick
	if floor_block == 3:
		speed = 100
	else:
		speed = 300
	#Math
	emit_signal("Block", position.x, position.y)
	emit_signal('Direction', facing)
	
#Dying and resetting states
func _on_AnimatedSprite_animation_finished():
	if state == states[4]:
		finished = true
	if is_on_floor():
		state = states[0]
		emit_signal("Ground")
	else:
		state = states[1]
		emit_signal("Air")
	

#Going in bubble
func _on_DarkMatter_body_entered(body):
	state = states[5]

#Powering up
func _on_Breaker_body_entered(body):
	breaker = true
	

#Grass script is every interactable block script fyi, too scared to change name
func _on_Grass_blocks(f_block, w_block):
	floor_block = f_block
	wall_block = w_block

#Making invincible false
func _on_Timer_timeout():
	invincibility = false
	timer = false
