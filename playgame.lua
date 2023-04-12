function update_playgame()
	if #game_objects == 0 then
		init_game()
	else
		for o in all(game_objects) do
			update_game_object(o)
		end
	end
end

function draw_playgame()
	rectfill(0,0,127,127,0)
	map(0, 0, 0, 0, 16, 16)
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
			o.x_speed = 1
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
			o.y_speed = 1
			if (o.target_y < o.y) then
				o.y -= o.y_speed
			else
				o.y += o.y_speed
			end
		end
		
	end
end

function update_player(o)
	if ((o.target_x == o.x) and (o.target_y == o.y)) then
		if btn(0) then
			o.target_x -= 8
		elseif btn(1) then
			o.target_x += 8
		elseif btn(2) then
			o.target_y -= 8
		elseif btn(3) then
			o.target_y += 8
		end
	end
end