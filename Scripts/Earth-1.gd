extends Node2D
var level = {
	"toSave" : "res://Scenes/Levels/Earth-1.tscn"
}
var save = File.new()
var loc = 'user://savefile.json'
func _on_Node2D_ready():
	print('probably saved')
	save.open(loc, File.READ_WRITE)
	save.store_var(level)
	var test = save.get_var()
	print(test)
	save.close()
