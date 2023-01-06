extends AudioStreamPlayer



func _on_Player_Dead():
	print('play')
	$DeathPlayer.play()
