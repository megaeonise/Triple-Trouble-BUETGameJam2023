extends Area2D

var processed: bool = false
var othertext: int = 0

func _process(delta):
		$Timer.start()


func _on_Timer_timeout():
	$RichTextLabel.set_text("")


func _on_Tutorial2_body_entered(body):
	$RichTextLabel.set_text("Don't waste your Destructors, lest you have reset to journey through this Sea.")
	$Timer.start()
