extends MenuButton




func _on_Controls_pressed():
	$spaceback.set_visible(true)
	$RichTextLabel.set_visible(true)
	$MenuButton.set_visible(true)


func _on_MenuButton_pressed():
	$spaceback.set_visible(false)
	$RichTextLabel.set_visible(false)
	$MenuButton.set_visible(false)
