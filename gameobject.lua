game_objects = {}

function init_game()
	for x=1,128 do
		for y=1, 32 do
			local s = mget(x,y)
			if (s == 2) then
				mset(x, y, 0)
				player = create_game_object(x*8, y*8, "player", 2)
				game_objects[#game_objects + 1] = player
			elseif (s == 5) then
				mset(x,y, 0)
				local enemy = create_game_object(x*8, y*8, "enemy", 5)
				game_objects[#game_objects + 1] = enemy
			end
		end
	end
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
		move_speed = 2
	}
	
	return game_object
end

function cardinal_dir_to_coord(angle)
	local coord = {x = 0, y = 0}
	
	if (angle == 0) then coord.x = 1
	elseif (angle == 90) then coord.y = -1
	elseif (angle == 180) then coord.x = -1
	elseif (angle == 270) then coord.y = 1 end

	return coord
end



function move_one_space_in_dir(game_object, dir)
	local coord = cardinal_dir_to_coord(dir)
	game_object.target_x += coord.x*8
	game_object.target_y += coord.y*8
end