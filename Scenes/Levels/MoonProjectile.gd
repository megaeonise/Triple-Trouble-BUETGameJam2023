extends KinematicBody2D

var shot_speed: int = 300
var shoot: bool = false
var shot_velocity = Vector2(0,200)
signal shot

func _physics_process(delta):
	if shoot:
		var collision = move_and_collide(shot_velocity*delta)
		if collision:
			var id = collision.get_collider_id()
			if id!=1639:
				position = Vector2(0,0)
			else:
				emit_signal('shot')
				position = Vector2(0,0)


func _on_ProjectileTimer_timeout():
	shoot = true
