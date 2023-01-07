extends KinematicBody2D

var shot_speed: int = 300
var shoot: bool = false
var shot_velocity = Vector2(0,200)
var og_pos = get_position()
var player_id: int
signal shot
signal restart
signal turn_off

func _physics_process(delta):
	if shoot:
		var collision = move_and_collide(shot_velocity*delta)
		if collision:
			$Projectile.set_emitting(false)
			shoot = false
			emit_signal('restart')
			var cid = collision.get_collider_id()
			if cid!=player_id:
				position = og_pos
			else:
				emit_signal('shot')
				position = og_pos


func _on_ProjectileTimer_timeout():
	shoot = true
	$Projectile.set_emitting(true)
	emit_signal('turn_off')


func _on_Player_ID(id):
	player_id = id
