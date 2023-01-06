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
			$RichTextLabel.set_text('The faster your horizontal speed when touching water, the further you bounce up')

func _on_Timer_timeout():
	$RichTextLabel.set_text('')
