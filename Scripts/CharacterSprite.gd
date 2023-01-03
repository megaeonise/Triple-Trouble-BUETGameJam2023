extends AnimatedSprite

onready var _animation = self

func _on_AnimatedSprite_animation_finished():
	if not get_animation() == 'Right Move':
		_animation.play('Idle')

func _on_Player_Jump():
	_animation.play('Jump')

func _on_Player_Right():
	if not get_animation() == 'Jump':
		_animation.play('Right Move')

func _on_Player_Stop():
	_animation.play('Idle')

func _on_Player_Left():
	if not get_animation() == 'Jump':
		_animation.play('Left Move')
