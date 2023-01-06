extends Area2D


var othertext: int = 0


func _on_Tutorial_body_entered(body):
	$Timer.start()
	match othertext:
		0:
			othertext = 1
			$RichTextLabel.set_text("Crystal's blessing stays with you for only one jump.")


func _on_Timer_timeout():
	$RichTextLabel.set_text('')
