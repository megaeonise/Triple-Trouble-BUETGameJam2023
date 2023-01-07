extends AnimatedSprite




func _on_TitleTimer_timeout():
	$MoonTimer.start()


func _on_MoonTimer_timeout():
	self.play('No Flame')
	$ProjectileTimer.start()
