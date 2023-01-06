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
			$RichTextLabel.set_text("Space Rock is benign, but it's other state Crystal hurts you but lets you jump higher. Interact to shift them between their two states.")
		1:
			othertext = 2
			$RichTextLabel.set_text('Lava heals and lets you move fast in the air.')
		2:
			othertext = 0
			$RichTextLabel.set_text("If you can't find a way forward, try Interacting.")


func _on_Tutorial_body_exited(body):
	$RichTextLabel.set_text('')


func _on_Timer_timeout():
	$RichTextLabel.set_text('')
