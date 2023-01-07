extends TileMap
var player_x: int
var player_y: int
var floor_block: int
var wall_block:int
var diag_block:int
var direction: bool
var player: Vector2
var local: Vector2
signal blocks(f_block, w_block)

func _on_Player_Block(x, y):
	player.x = x
	player.y = y
	local = world_to_map(player)
	

func _process(delta):
	#Bot Cell
	floor_block = get_cell(local.x, local.y+1)
	#Side Cell
	if direction:
		wall_block = get_cell(local.x-1, local.y)
	else:
		wall_block = get_cell(local.x+1, local.y)
	#Diag Cell
	if direction:
		diag_block = get_cell(local.x-1, local.y+1)
	else:
		diag_block = get_cell(local.x+1, local.y+1)
	emit_signal('blocks', floor_block, wall_block)

func _on_Player_Direction(facing):
	direction = facing

func _on_Player_Interact(breaker):
	if breaker:
		if direction:
			for length in range(3, 0, -1):
				for height in range(3):
					set_cell(local.x-length, local.y-1+height, -1)
		else:
			for length in range(3):
				for height in range(3):
					set_cell(local.x+1+length, local.y-1+height, -1)
	else:
		if wall_block!=-1:
			if direction:
				match wall_block:
					0:
						set_cell(local.x-1, local.y, 1)
					1:
						set_cell(local.x-1, local.y, 0)
					10:
						set_cell(local.x-1, local.y, 3)
					3:
						set_cell(local.x-1, local.y, 10)
					6:
						set_cell(local.x-1, local.y, 8)
					8:
						set_cell(local.x-1, local.y, 6)
					11:
						set_cell(local.x-1, local.y, 15)
					15:
						set_cell(local.x-1, local.y, 11)
					13:
						set_cell(local.x-1, local.y, 16)
					16:
						set_cell(local.x-1, local.y, 13)
					17:
						set_cell(local.x-1, local.y, 18)
					18:
						set_cell(local.x-1, local.y, 17)
			else:
				match wall_block:
					0:
						set_cell(local.x+1, local.y, 1)
					1:
						set_cell(local.x+1, local.y, 0)
					10:
						set_cell(local.x+1, local.y, 3)
					3:
						set_cell(local.x+1, local.y, 10)
					6:
						set_cell(local.x+1, local.y, 8)
					8:
						set_cell(local.x+1, local.y, 6)
					11:
						set_cell(local.x+1, local.y, 15)
					15:
						set_cell(local.x+1, local.y, 11)
					13:
						set_cell(local.x+1, local.y, 16)
					16:
						set_cell(local.x+1, local.y, 13)
					17:
						set_cell(local.x+1, local.y, 18)
					18:
						set_cell(local.x+1, local.y, 17)
		elif diag_block!=-1:
			if direction:
				match diag_block:
					0:
						set_cell(local.x-1, local.y+1, 1)
					1:
						set_cell(local.x-1, local.y+1, 0)
					10:
						set_cell(local.x-1, local.y+1, 3)
					3:
						set_cell(local.x-1, local.y+1, 10)
					6:
						set_cell(local.x-1, local.y+1, 8)
					8:
						set_cell(local.x-1, local.y+1, 6)
					11:
						set_cell(local.x-1, local.y+1, 15)
					15:
						set_cell(local.x-1, local.y+1, 11)
					13:
						set_cell(local.x-1, local.y+1, 16)
					16:
						set_cell(local.x-1, local.y+1, 13)
					17:
						set_cell(local.x-1, local.y+1, 18)
					18:
						set_cell(local.x-1, local.y+1, 17)
			else:
				match diag_block:
					0:
						set_cell(local.x+1, local.y+1, 1)
					1:
						set_cell(local.x+1, local.y+1, 0)
					10:
						set_cell(local.x+1, local.y+1, 3)
					3:
						set_cell(local.x+1, local.y+1, 10)
					6:
						set_cell(local.x+1, local.y+1, 8)
					8:
						set_cell(local.x+1, local.y+1, 6)
					11:
						set_cell(local.x+1, local.y+1, 15)
					15:
						set_cell(local.x+1, local.y+1, 11)
					13:
						set_cell(local.x+1, local.y+1, 16)
					16:
						set_cell(local.x+1, local.y+1, 13)
					17:
						set_cell(local.x+1, local.y+1, 18)
					18:
						set_cell(local.x+1, local.y+1, 17)

