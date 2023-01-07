extends AnimatedSprite
onready var _anim = self



func _on_TitleTimer_timeout():
	$MoonTimer.start()


func _on_MoonTimer_timeout():
	_anim.play('No Flame')
	$ProjectileTimer.start()


func _on_Player_Moonhurt():
	$Taunt.set_emitting(true)


func _on_ProjectileArea_restart():
	$MoonTimer.start()
	


func _on_ProjectileArea_shot():
	$Taunt.set_emitting(true)
	$AudioStreamPlayer2.play()


func _on_ProjectileArea_turn_off():
	_anim.play('NFStatic')


func _on_ProjectileTimer_timeout():
	$AudioStreamPlayer.play()
