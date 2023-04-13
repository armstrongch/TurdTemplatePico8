function update_playgame()
	for o in all(game_objects) do
		update_game_object(o)
	end
end

function draw_playgame()
	rectfill(player.x-65,player.y-65,player.x+65,player.y+65,0)
	camera(player.x-64, player.y-64)
	map()
	for o in all(game_objects) do
		draw_game_object(o)
	end
end

function draw_game_object(o)
	spr(o.sprite_index, o.x, o.y)
end

function update_game_object(o)
	if o.obj_type == "player" then update_player(o) end
	
	if ((o.target_x != o.x) or (o.target_y != o.y)) then
		
		if (abs(o.target_x - o.x) <= o.x_speed) then 
			o.x = o.target_x
			o.x_speed = 0
		else
			o.x_speed = o.move_speed
			if (o.target_x < o.x) then
				o.x -= o.x_speed
			else
				o.x += o.x_speed
			end
		end
		
		if (abs(o.target_y - o.y) <= o.y_speed) then 
			o.y = o.target_y
			o.y_speed = 0
		else
			o.y_speed = o.move_speed
			if (o.target_y < o.y) then
				o.y -= o.y_speed
			else
				o.y += o.y_speed
			end
		end
		
	end
end

collision_map_sprites = { 1, 3, 4}

function update_player(o)
	if ((o.target_x == o.x) and (o.target_y == o.y)) then
		if btn(0) then
			o.target_x -= 8
			o.prev_move_dir = 180
		elseif btn(1) then
			o.target_x += 8
			o.prev_move_dir = 0
		elseif btn(2) then
			o.target_y -= 8
			o.prev_move_dir = 90
		elseif btn(3) then
			o.target_y += 8
			o.prev_move_dir = 270
		end
		
		 
	end
	
	local target_space = mget(o.target_x/8, o.target_y/8)
	
	for s in all(collision_map_sprites) do
		if (target_space == s) then
			o.target_x = o.x
			o.target_y = o.y
			show_conversation(target_space, 0)
		end
	end

end