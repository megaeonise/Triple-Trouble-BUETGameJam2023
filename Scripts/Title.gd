extends Sprite

func _ready():
	$Particle.set_emitting(true)



func _on_TitleTimer_timeout():
	self.set_visible(false)
