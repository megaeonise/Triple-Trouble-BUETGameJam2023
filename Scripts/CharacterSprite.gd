extends AnimatedSprite

#Variables
onready var _animation = self
var facing = false
var air = false
var finished = true

#Handling Animation Stopping
func _on_AnimatedSprite_animation_finished():
	finished == true
	if not get_animation() == 'Right Move' and not get_animation() == 'Left Move':
		if facing == false:
			_animation.play('Idle')
		else:
			_animation.play('Left Idle')

#Jump Animation
func _on_Player_Jump():
	finished = false
	if facing == false:
		_animation.play('Jump')
	else:
		_animation.play('Left Jump')

func _on_Player_Right_Dash():
	finished = false
	_animation.play('Right Dash')


func _on_Player_Left_Dash():
	finished = false
	_animation.play('Left Dash')

#Setting direction flag for right and playing right move animation
func _on_Player_Right():
	facing = false
	if finished:
		_animation.play('Right Move')

#Setting direction flag for left and playing left move animation
func _on_Player_Left():
	facing = true
	if finished:
		_animation.play('Left Move')

#Setting flag for being on ground and playing Idle animation, this is used for jumping in place
func _on_Player_Stop():
	if air == false:
		if facing == false:
			_animation.play('Idle')
		else:
			_animation.play('Left Idle')

#Setting flag for being in air
func _on_Player_Air():
	air = true

#Setting flag for being on ground in general
func _on_Player_Ground():
	air = false



