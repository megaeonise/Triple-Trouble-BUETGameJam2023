extends AnimatedSprite
onready var _anim = self
var phase: int = 3

func _on_TitleTimer_timeout():
	$MoonTimer.start()


func _on_MoonTimer_timeout():
	match phase:
		0:
			_anim.play('No Flame')
		1:
			_anim.play('1 Flame')
		2:
			_anim.play('2 Flame')
		3:
			$AudioStreamPlayer.play()
			$Final.start()
	$ProjectileTimer.start()


func _on_Player_Moonhurt():
	$Taunt.set_emitting(true)


func _on_ProjectileArea_restart():
	$MoonTimer.start()
	


func _on_ProjectileArea_shot():
	$Taunt.set_emitting(true)
	$AudioStreamPlayer2.play()


func _on_ProjectileArea_turn_off():
	match phase:
		0:
			_anim.play('NFStatic')
		1:
			_anim.play('1FStatic')
		2:
			_anim.play('2FStatic')


func _on_ProjectileTimer_timeout():
	$AudioStreamPlayer.play()


func _on_Grass_cannon_fired(cannon_number):
	print('tt')
	phase += 1
	match phase:
		1:
			_anim.play('1FStatic')
		2:
			_anim.play('2FStatic')
		3:
			_anim.play('3 Flame')
			$AudioStreamPlayer.play()
			$Final.start()
	$ProjectileTimer.start()
	$Fire.set_emitting(true)


func _on_Final_timeout():
	get_tree().change_scene("res://Scenes/Levels/Ending.tscn")
