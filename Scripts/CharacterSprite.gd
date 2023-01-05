extends AnimatedSprite

#Variables(For facing, false is right and true is left.)
onready var _animation = self
var facing = false
var air = false
var finished = false

#Handling Animation Stopping
func _on_AnimatedSprite_animation_finished():
	if not (get_animation()=='Idle' or get_animation()=='Left Idle'):
		finished = true


#Jump Animation
func _on_Player_Jump():
	finished = false
	if facing == false:
		_animation.play('Jump')
	else:
		_animation.play('Left Jump')

func _on_Player_Interact():
	finished = false
	if facing == true:
		_animation.play('Left Interact')
	else:
		_animation.play('Right Interact')

#Right Dash
func _on_Player_Right_Dash():
	finished = false
	_animation.play('Right Dash')

#Left Dash
func _on_Player_Left_Dash():
	finished = false
	_animation.play('Left Dash')

#Setting direction flag for right and playing right move animation
func _on_Player_Right():
	if finished == true:
		facing = false
		_animation.play('Right Move')

#Setting direction flag for left and playing left move animation
func _on_Player_Left():
	if finished == true:
		facing = true
		_animation.play('Left Move')

#Setting flag for being on ground and playing Idle animation, this is used for jumping in place
func _on_Player_Stop():
	if air == false and finished == true:
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
