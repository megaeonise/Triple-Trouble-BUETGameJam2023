extends TextureProgress

func _ready():
	self.set_visible(false)

func _on_Player_Healed():
	$HPTimer.start()
	value+=1
	self.set_visible(true)
	

func _on_Player_Hurt():
	$HPTimer.start()
	value-=1
	self.set_visible(true)

func _on_HPTimer_timeout():
	self.set_visible(false)
