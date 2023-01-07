extends KinematicBody2D
#Variables
var minhp: int = 0
var maxhp: int = 5
var hp: int = 5
var speed: int = 300
var jumpspeed: int = -200
var gravity: int = 500
var velocity = Vector2()
var states: Array = ['Ground', 'Air', 'Dash', 'Interact', 'Death', 'Blob']
var state: String = states[0]
var finished: bool = false
var facing: bool = false
var breaker: int = 0
var floor_block: int = -1
var wall_block: int = -1
var invincibility: bool = false
var timer: bool = false
var can_emit: bool = false
var can_jump: bool = false
var super_jump: bool = false
var lava: bool = false
var super_jump_ready: bool = false
var dedsfx: bool = false
var jumpsfx: bool = false
var dashsfx: bool = false
var intsfx: bool = false
var ice: bool = true
var moon: bool = true
var dirt: bool = true
var grass: bool = true
var can_sound: bool = false
var t_grav: int = 0
var t_x: int = 0
var t_y: int = 0
var t_j: int = 0
var t_s: int = 0
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
signal Hurt
signal Healed
signal Crystal
signal Lava
signal Moonhurt
signal ID(id)
#Controls
func _ready():
	if not get_tree().get_current_scene().get_name() == "Sea":
		$LoadPlayer.play()
func get_input(delta):
	#Initial Velocity
	velocity.x = 0
	#Setting Ground state after returning from Air
	if is_on_floor() and state == states[1] and not state in states.slice(2,5):
		can_jump = true
		state = states[0]
		ice = false
		moon = false
		dirt = false
		grass = false
		emit_signal('Ground')
		$AnimatedSprite.visible = true
	#Setting Air state after falling
	if is_on_floor()!=true and not state in states.slice(2,5):
		$Coyote.start()
		if not can_jump:
			state = states[1]
			emit_signal('Air')
		$AnimatedSprite.visible = true
	if state == states[5]:
		velocity.x = 0
		velocity.y = 0
		$AnimatedSprite.visible = false
		if Input.is_action_just_pressed("move_left"):
			velocity.x-= speed+speed*10*1.67
			state = states[1]
			gravity = 500
			$AnimatedSprite.visible = true
		elif Input.is_action_just_pressed("move_right"):
			velocity.x+= speed+speed*10*1.67
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
			if not jumpsfx and can_sound:
				jumpsfx = true
				$JumpPlayer.play()
			if super_jump:
				state = states[1]
				velocity.y+=jumpspeed*2.5
				super_jump = false
				emit_signal('Jump')
				emit_signal('Air')
			else:
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
			if lava:
				emit_signal("Lava")
				#Right Move
				if Input.is_action_pressed("move_right"):
					facing = false
					velocity.x += speed*1.7
					emit_signal('Right')
				#Left Move
				elif Input.is_action_pressed("move_left"):
					facing = true
					velocity.x -= speed*1.7
					emit_signal('Left')
				#Stop Signal
				else:
					emit_signal("Stop")
			else:
				#Right Move
				if Input.is_action_pressed("move_right"):
					facing = false
					velocity.x += speed*0.5
					emit_signal('Right')
				#Left Move
				elif Input.is_action_pressed("move_left"):
					facing = true
					velocity.x -= speed*0.5
					emit_signal('Left')
				#Stop Signal
				else:
					emit_signal("Stop")
		#Right Dash
		if Input.is_action_just_pressed("dash") and Input.is_action_pressed('move_right'):
			if not dashsfx and can_sound:
				$DashPlayer.play()
			#Right Ground Dash
			if state == states[0]:
				emit_signal('Right_Dash')
				velocity.x += 5000

			#Right Air Dash
			else:
				state = states[2]
				emit_signal('Right_Dash')
				velocity.x += 5000
		
		#Left Dash
		
		if Input.is_action_just_pressed("dash") and Input.is_action_pressed('move_left'):
			#Left Ground Dash
			if not dashsfx and can_sound:
				dashsfx = true
				$DashPlayer.play()
			if state == states[0]:
				emit_signal('Left_Dash')
				velocity.x -= 5000
			#Left Air Dash
			else:
				state = states[2]
				emit_signal('Left_Dash')
				velocity.x -= 5000
		#Interact
		if Input.is_action_just_pressed("interact"):
			if can_sound:
				$InteractPlayer.play()
			finished = false
			state = states[3]
			emit_signal('Interact', false)
		if Input.is_action_just_pressed("destroy") and breaker>0:
			t_grav = gravity
			t_x = velocity.x
			t_y = velocity.y
			t_j = jumpspeed
			t_s = speed
			gravity = 0
			velocity.x = 0
			velocity.y = 0
			speed = 0
			jumpspeed = 0
			finished = false
			state = states[3]
			if can_sound:
				$DestroyPlayer.play()
			emit_signal('Interact', breaker)
			breaker -= 1
			$CPUParticles2D.set_emitting(false)
			if not facing:
				$Destroball.set_emitting(true)
				$Destructor1.set_emitting(true)
				$Destructor1/Des_Time1.start()
			else:
				$Destroball2.set_emitting(true)
				$DestructorL1.set_emitting(true)
				$DestructorL1/Des_Time1L.start()
		elif Input.is_action_pressed("destroy") and breaker==0:
			$RichTextLabel2.set_bbcode("[center]No Destructor[/center]")
			$RichTextLabel2/Background.set_visible(true)
			$Timer2.start()
	
	#Gravity
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
#Driver code
func _physics_process(delta):
	var id = self.get_instance_id()
	emit_signal('ID', id)
	get_input(delta)
	#Powered-Up
	if breaker>0:
		$CPUParticles2D.set_emitting(true)
		if can_emit:
			$RichTextLabel/Background.set_visible(true)
			$CPUParticles2D2.set_emitting(true)
			$RichTextLabel.set_bbcode("[center]Destructor obtained. You've only one shot.[/center]")
	#Death
	if hp==0:
		state=states[4]
		if not dedsfx:
			dedsfx = true
			if can_sound:
				$DeathPlayer.play()
		emit_signal('Dead')
	if Input.is_action_just_pressed("die"):
		hp = 0
	#Damage
	if (floor_block == 0 or floor_block == 16) and invincibility == false and hp>0:
		hp-=1
		$Hurt.set_emitting(true)
		invincibility = true
		$Timer.start()
		emit_signal('Hurt')
	if finished == true and hp==0:
		hp = 5
		get_tree().reload_current_scene()
	#Bounce
	if (floor_block == 10 or floor_block == 18) and timer==false:
		timer=true
		$Timer.start()
		velocity.y -= 500
		if can_sound:
			$WaterPlayer.play()
		$Water.set_emitting(true)
	#Icestick
	if floor_block == 3 or floor_block == 17:
		speed = 100
		if not ice:
			ice = true
			if can_sound:
				$IcePlayer.play()
	#Lava
	elif (floor_block == 7 or floor_block == 14):
		if hp!=maxhp:
			if can_sound:
				$LavaPlayer.play()
				$HealedPlayer.play()
			hp+=1
			$Healed.set_emitting(true)
			emit_signal("Healed")
		speed = 500
		lava = true
		$Lava.set_emitting(true)
		$Timer2.start()
	else:
		speed = 300
	if not lava:
		$Lava.set_emitting(false)
	#Crystal
	if (floor_block == 8 or floor_block == 11):
		if invincibility == false:
			if hp>0:
				hp-=1
				$Hurt.set_emitting(true)
				emit_signal('Hurt')
				invincibility = true
				$Timer.start()
		if not super_jump_ready:
			if can_sound:
				$CrystalPlayer.play()
			super_jump = true
			super_jump_ready = true
			$CrystalTimer.start()
	if super_jump:
		$Crystal.set_emitting(true)
		emit_signal("Crystal")
	else:
		$Crystal.set_emitting(false)
	#Moon Rock
	if floor_block in [6,9,15]:
		if not moon:
			moon = true
			if can_sound:
				$MoonRPlayer.play()
	#Dirt
	if floor_block in [12,5,4]:
		if not dirt:
			dirt = true
			if can_sound:
				$DirtPlayer.play()
	if floor_block in [0,1,13,16]:
		if not grass:
			grass= true
			if can_sound:
				$GrassPlayer.play()
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
	if can_sound:
		$RubyPlayer.play()
	breaker += 1
	can_emit = true
	$Timer2.start()
	

#Grass script is every interactable block script fyi, too scared to change name
func _on_Grass_blocks(f_block, w_block):
	floor_block = f_block
	wall_block = w_block

#Making invincible false
func _on_Timer_timeout():
	invincibility = false
	timer = false


func _on_Timer2_timeout():
	if lava:
		lava = false
	else:
		can_emit = false
		$RichTextLabel.set_text("")
		$RichTextLabel/Background.set_visible(false)
		$RichTextLabel2.set_text("")
		$RichTextLabel2/Background.set_visible(false)


func _on_Coyote_timeout():
	can_jump=false


func _on_Fire_body_entered(body):
	if hp!=maxhp:
		hp+=1
		if can_sound:
			$HealedPlayer.play()
		$Healed.set_emitting(true)
		emit_signal("Healed")


func _on_Death_Plane_body_entered(body):
	hp=0


func _on_CrystalTimer_timeout():
	super_jump_ready = false


func _on_Des_Time1_timeout():
	$"Destructor Impact Frame 1".set_emitting(true)
	$"Destructor Impact Frame 1/Des_Time2".start()


func _on_Des_Time2_timeout():
	$"Destructor Impact Frame 1/Destructor Impact Impact Frame 1".set_emitting(true)
	$"Destructor Impact Frame 1/Destructor Impact Impact Frame 1/Des_Time3".start()


func _on_Des_Time3_timeout():
	$"Destructor Impact Frame 2".set_emitting(true)
	$"Destructor Impact Frame 2/Des_Time4".start()


func _on_Des_Time4_timeout():
	$"Destructor Impact Frame 2/Destructor Impact Impact Frame 2".set_emitting(true)
	$"Destructor Impact Frame 2/Destructor Impact Impact Frame 2/Des_Time5".start()


func _on_Des_Time5_timeout():
	$Destroball.set_emitting(false)
	$Destructor2.set_emitting(true)
	$Destructor2/Des_Time6.start()
	
func _on_Des_Time1L_timeout():
	$"DestructorL Impact Frame 1".set_emitting(true)
	$"DestructorL Impact Frame 1/Des_Time2L".start()


func _on_Des_Time2L_timeout():
	$"DestructorL Impact Frame 1/DestructorL Impact Impact Frame 1".set_emitting(true)
	$"DestructorL Impact Frame 1/DestructorL Impact Impact Frame 1/Des_Time3L".start()


func _on_Des_Time3L_timeout():
	$"DestructorL Impact Frame 2".set_emitting(true)
	$"DestructorL Impact Frame 2/Des_Time4L".start()


func _on_Des_Time4L_timeout():
	$"DestructorL Impact Frame 2/DestructorL Impact Impact Frame 2".set_emitting(true)
	$"DestructorL Impact Frame 2/DestructorL Impact Impact Frame 2/Des_Time5L".start()


func _on_Des_Time5L_timeout():
	$Destroball2.set_emitting(false)
	$DestructorL2.set_emitting(true)
	$DestructorL2/Des_Time6L.start()



func _on_DeathPlayer_finished():
	$DeathPlayer.stop()


func _on_JumpPlayer_finished():
	jumpsfx = false


func _on_DashPlayer_finished():
	dashsfx = false



func _on_Des_Time6_timeout():
	gravity = t_grav
	velocity.x = t_x
	velocity.y = 0
	speed = t_s
	jumpspeed = t_j
	t_grav = 0
	t_x = 0
	t_y = 0
	t_s = 0
	t_j = 0


func _on_Des_Time6L_timeout():
	gravity = t_grav
	velocity.x = t_x
	velocity.y = 0
	speed = t_s
	jumpspeed = t_j
	t_grav = 0
	t_x = 0
	t_y = 0
	t_s = 0
	t_j = 0
	



func _on_InteractPlayer_finished():
	intsfx = false


func _on_Start_timeout():
	can_sound = true


func _on_ProjectileArea_shot():
	if not invincibility:
		$Timer.start()
		invincibility = true
		hp-=1
		$Hurt.set_emitting(true)
		emit_signal('Hurt')
		emit_signal('Moonhurt')
		velocity.y += jumpspeed*0.5
		velocity.x = speed/speed
