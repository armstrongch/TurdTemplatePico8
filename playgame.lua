--player cannot walk through these sprites on the map
collision_map_sprites = { 1, 3, 4 }

function update_playgame()
	for o in all(game_objects) do
		update_game_object(o)
	end
end

function draw_playgame()
	rectfill(player.x-70,player.y-70,player.x+70,player.y+70,0)
	camera(player.x-60, player.y-60)
	map()
	for o in all(game_objects) do
		draw_game_object(o)
	end
	
	draw_ui()
end

function draw_game_object(o)
	if (o.obj_type == "enemy") then draw_enemy(o)
	else
		spr(o.sprite_index, o.x, o.y)
	end
end

function update_game_object(o)
	if o.obj_type == "player" then update_player(o) end
	if o.obj_type == "enemy" then update_enemy(o) end
	if o.obj_type == "patroller" then update_patroller(o) end
	
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

function update_player(o)
	
	if btnp(4) then state = "inventory" end
	
	if #inventory_items < max_inv_items then
		local current_space_sprite = mget(o.x/8, o.y/8)
		for i in all(item_pickup_sprites) do
			if i[1] == current_space_sprite then
				mset(o.x/8, o.y/8, 0)
				inventory_items[#inventory_items + 1] = current_space_sprite
			end
		end
	end
	
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
		
		if o.target_x != o.x or o.target_y != o.y then sound("walk") end
	end
	
	local target_space = { x = o.target_x/8, y = o.target_y/8 }
	local target_space_collider = space_collider(target_space)
	
	
	if target_space_collider != 0 then
		o.target_x = o.x
		o.target_y = o.y
		show_conversation(target_space_collider, 0)
	end
end

--Returns collider index if space contains a collider, otherwise returns 0
function space_collider(space)
	local collider_index = mget(space.x, space.y)
	for s in all(collision_map_sprites) do
		if (s == collider_index) then
			return collider_index
		end
	end
	return 0
end