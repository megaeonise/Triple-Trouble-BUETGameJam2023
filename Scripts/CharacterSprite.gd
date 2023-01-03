extends AnimatedSprite

onready var _animation = self
var facing = false
var air = false

func _on_AnimatedSprite_animation_finished():
	if not get_animation() == 'Right Move' and not get_animation() == 'Left Move':
		if facing == false:
			_animation.play('Idle')
		else:
			_animation.play('Left Idle')

func _on_Player_Jump():
	if facing == false:
		_animation.play('Jump')
	else:
		_animation.play('Left Jump')

func _on_Player_Right():
	facing = false
	if not get_animation() == 'Jump' and not get_animation() == 'Left Jump':
		_animation.play('Right Move')

func _on_Player_Left():
	facing = true
	if not get_animation() == 'Left Jump' and not get_animation() == 'Jump':
		_animation.play('Left Move')

func _on_Player_Stop():
	if air == false:
		if facing == false:
			_animation.play('Idle')
		else:
			_animation.play('Left Idle')

func _on_Player_Air():
	air = true

func _on_Player_Ground():
	air = false
