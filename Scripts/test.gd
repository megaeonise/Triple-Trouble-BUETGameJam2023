extends KinematicBody2D

var shot_speed: int = 300
var shoot: bool = true
var shot_velocity = Vector2()

func _physics_process(delta):
	if shoot:
		shot_velocity = move_and_collide(Vector2.DOWN)
