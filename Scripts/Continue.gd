extends MenuButton


func _on_Continue_pressed():
	$PopupMenu2.popup()


func _on_PopupMenu2_id_pressed(id):
	match id:
		0:
			get_tree().change_scene("res://Scenes/Levels/Earth-1.tscn")
		1:
			get_tree().change_scene("res://Scenes/Levels/Earth-2.tscn")
		2:
			get_tree().change_scene("res://Scenes/Levels/Earth-3.tscn")
		3:
			get_tree().change_scene("res://Scenes/Levels/Space-1.tscn")
		4:
			get_tree().change_scene("res://Scenes/Levels/Space-2.tscn")
		5:
			get_tree().change_scene("res://Scenes/Levels/Space-3.tscn")
		6:
			get_tree().change_scene("res://Scenes/Levels/Distortion-1.tscn")
		7:
			get_tree().change_scene("res://Scenes/Levels/Distortion-2.tscn")
		8:
			get_tree().change_scene("res://Scenes/Levels/Distortion-3.tscn")
		9:
			get_tree().change_scene("res://Scenes/Levels/Sea.tscn")
		10:
			get_tree().change_scene("res://Scenes/Levels/Credits.tscn")
