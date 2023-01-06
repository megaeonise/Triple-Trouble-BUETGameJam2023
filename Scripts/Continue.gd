extends MenuButton

var loc = 'user://savefile.json'
var save = File.new()
func _on_Continue_pressed():
	save.open(loc, File.READ)
	if save.file_exists(loc):
		var reload = save.get_var()
		print('wtf')
		print(reload)
		save.close()
