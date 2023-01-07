extends Area2D

var processed: bool = false
var othertext: int = 0

func _process(delta):
		$Timer.start()


func _on_Timer_timeout():
	$RichTextLabel.set_text('')
