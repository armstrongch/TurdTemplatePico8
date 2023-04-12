game_objects = {}

function init_game()
	player = create_game_object(16, 16, "player", 2)
	game_objects[#game_objects + 1] = player
end

function create_game_object(in_x, in_y, in_obj_type, in_sprite_index)
	local game_object = {
		x = in_x,
		y = in_y,
		target_x = in_x,
		target_y = in_y,
		obj_type = in_obj_type,
		sprite_index = in_sprite_index,
		x_speed = 0,
		y_speed = 0,
		move_speed = 2,
	}
	
	return game_object
end