cash = 3

inventory_items = {}
inventory_index = 1

max_inv_items = 24
inv_row_items = 8

item_pickup_sprites = {
	{ 7, "apple: +dmg vs doctors" },
	{ 8, "orange: +vitamin c" },
	{ 9, "shipping crate: \n this is a test of the \n multi-line item \n descriptions" }
}

function use_item()
	if inventory_index <= #inventory_items then
		local item_to_use = inventory_items[inventory_index]
		if 1 != 1 then
			--add conditions for special items here
		else
			--this item had no special effect, and hitting the item button drops the item
			local space_to_drop = next_space_in_player_dir()
			if mget(space_to_drop.x, space_to_drop.y) == 0 then
				mset(space_to_drop.x, space_to_drop.y, del(inventory_items, item_to_use))
			end
		end
	end
end

function next_space_in_player_dir()
	local next_space = { x = player.target_x/8, y = player.target_y/8 }
	
	if player.prev_move_dir == 180 then
		next_space.x -= 1
	elseif player.prev_move_dir == 0 then
		next_space.x += 1
	elseif player.prev_move_dir == 90 then
		next_space.y -= 1
	else --270
		next_space.y += 1
	end
	
	return next_space
end

function get_inventory_desc(sprite)
	for i in all(item_pickup_sprites) do
		if i[1] == sprite then return i[2] end
	end
	return ""
end

function update_inventory()
	if btnp(0) then
		if inventory_index % 8 == 1 then inventory_index += 7 else inventory_index -= 1 end
	elseif btnp(1) then
		if inventory_index % 8 == 0 then inventory_index -= 7 else inventory_index += 1 end
	elseif btnp(2) then
		if inventory_index <= 8 then inventory_index += 16 else inventory_index -= 8 end
	elseif btnp(3) then
		if inventory_index >= 17 then inventory_index -= 16 else inventory_index += 8 end
	elseif btnp(4) then state = "playgame" end
	
end

function draw_inventory()
	camera(0,0)
	rectfill(0,0,127,127,0)
	print("inventory", 16, 8, 7)
	
	local x_pos = 16
	local y_pos = 16
	for i=1,max_inv_items do
		local color = 7
		if i <= #inventory_items then
			spr(inventory_items[i], x_pos, y_pos)
			if i == inventory_index then
				print(get_inventory_desc(inventory_items[i]), 16, ceil(max_inv_items/inv_row_items)*12+20)
			end
		end
		
		if i == inventory_index then
			color = 8
		end
		
		rect(x_pos-1, y_pos-1, x_pos+8, y_pos+8, color)
		
		x_pos += 12
		if x_pos-16 >= inv_row_items*12 then
			x_pos = 16
			y_pos += 12
		end
	end
	
	print("🅾️ exit", 16, 116, 7)
end