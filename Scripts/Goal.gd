extends Area2D

var done: bool = false

func _on_Goal_body_entered(body):
	if not done:
		done = true
		$Timer.start()
		$Audio.play()
	

func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/Levels/Earth-2.tscn")
	
