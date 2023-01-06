extends Area2D


var othertext: int = 0


func _on_Tutorial_body_entered(body):
	$Timer.start()
	match othertext:
		0:
			othertext = 1
			$RichTextLabel.set_text("The power of Lava stays with you for a short while.")


func _on_Timer_timeout():
	$RichTextLabel.set_text('')
