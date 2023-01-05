extends TileMap
var player_x: int
var player_y: int
var floor_block: int
var wall_block:int
var direction: bool
var player: Vector2
var local: Vector2

func _on_Player_Block(x, y):
	player.x = x
	player.y = y
	local = world_to_map(player)
	

func _process(delta):
	#Bot Cell
	floor_block = get_cell(local.x, local.y-1)
	#Side Cell
	if direction:
		wall_block = get_cell(local.x-1, local.y)
	else:
		wall_block = get_cell(local.x+1, local.y)

func _on_Player_Direction(facing):
	direction = facing


func _on_Player_Interact(breaker):
	if breaker:
		if direction:
			for length in range(3, 0, -1):
				for height in range(3):
					set_cell(local.x-length, local.y-1+height, -1)
					print(local.x-1-length, local.y-1+height, -1)
		else:
			for length in range(3):
				for height in range(3):
					set_cell(local.x+1+length, local.y-1+height, -1)
					print(local.x+1-length, local.y-1+height, -1)
	else:
		if wall_block!=-1:
			if direction:
				if wall_block==0:
					set_cell(local.x-1, local.y, 1)
				else:
					set_cell(local.x-1, local.y, 0)
			else:
				if wall_block==0:
					set_cell(local.x+1, local.y, 1)
				else:
					set_cell(local.x+1, local.y, 0)
