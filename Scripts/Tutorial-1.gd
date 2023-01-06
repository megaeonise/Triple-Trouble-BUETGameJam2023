extends Area2D

var processed: bool = false
var othertext: bool = false

func _process(delta):
	if processed == false:
		processed = true
		$Timer.start()

func _on_Tutorial_body_entered(body):
	if not othertext:
		$RichTextLabel.set_text('Blades of grass hurt, water bounces, ice sticks. Interact to change the environment and be on your way.')
		othertext = true
	else:
		othertext = false
		$RichTextLabel.set_text('Take the red Breaker to blow away obstacles')


func _on_Tutorial_body_exited(body):
	$RichTextLabel.set_text('')


func _on_Timer_timeout():
	$RichTextLabel.set_text('')
