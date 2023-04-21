function update_patroller(o)
	
	if ((o.target_x == o.x) and (o.target_y == o.y)) then
		local possible_moves = {
			{ x = o.x/8 + 1, y = o.y/8 },	--right
			{ x = o.x/8, y = o.y/8 + 1 },	--down
			{ x = o.x/8 - 1, y = o.y/8 },	--left
			{ x = o.x/8, y = o.y/8 - 1 }	--up
		}
		local move_index = o.prev_move_index
		for i=0,3 do
			local test_index = o.prev_move_index + i
			if test_index > 4 then test_index -= 4 end
			local target_space = possible_moves[test_index]
			--print(target_space.x .. ", " .. target_space.y, 16, 16, 8)
			--stop()
			if space_collider(target_space) == 0 then
				o.target_x = target_space.x*8
				o.target_y = target_space.y*8
				o.prev_move_index = test_index
				break;
			end
		end
	end
end