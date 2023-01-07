extends KinematicBody2D

var cshot_speed: int = 300
var cshoot: bool = false
var cshot_velocity = Vector2(0,-2000)

func _physics_process(delta):
	if cshoot:
		var ccollision = move_and_collide(cshot_velocity*delta)
		if ccollision:
			queue_free()


func _on_Grass_cannon_fired(cannon_number):
	if cannon_number==0:
		cshoot = true
