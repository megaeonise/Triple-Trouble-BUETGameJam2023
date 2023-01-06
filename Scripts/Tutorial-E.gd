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
			$RichTextLabel.set_text('Your Interact affects Half-Blocks in front of you and in front of you and below you.')
			
		1:
			othertext = 2
			$RichTextLabel.set_text('Grass cuts, but is harmless when cut. Interact shifts Grass between these two forms.')
			
		2:
			othertext = 3
			$RichTextLabel.set_text('Water bounces, and Ice sticks. Interact shifts Water between these two forms.')
		3:
			othertext = 0
			$RichTextLabel.set_text('Your Interact only affects Half-Blocks, Full Blocks are completely unaffected.')
			


func _on_Tutorial_body_exited(body):
	$RichTextLabel.set_text('')


func _on_Timer_timeout():
	$RichTextLabel.set_text('')
