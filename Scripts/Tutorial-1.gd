extends Area2D

var processed: bool = false
var othertext: int = 0

func _process(delta):
	if processed == false:
		processed = true
		$Timer.start()

func _on_Tutorial_body_entered(body):
	match othertext:
		0:
			othertext = 1
			$RichTextLabel.set_text('Lava heals, Crystal hurts. But Crystal gives you the power to jump high.')
		1:
			othertext = 0
			$RichTextLabel.set_text('Lava also lets you move fast.')


func _on_Tutorial_body_exited(body):
	$RichTextLabel.set_text('')


func _on_Timer_timeout():
	$RichTextLabel.set_text('')
