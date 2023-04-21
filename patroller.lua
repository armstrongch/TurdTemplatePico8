function update_patroller(o)
	
	update_enemy(o)

	if ((o.target_x == o.x) and (o.target_y == o.y)) then
		
		if o.draw_exclamation then
			o.last_player_sighting_space = { x = flr(player.x/8), y = flr(player.y/8), resolved = false }
		end
		
		if not o.last_player_sighting_space.resolved then
			local target_space = closest_empty_adjacent_space( { x = o.x/8, y = o.y/8 }, o.last_player_sighting_space );
			o.target_x = target_space.x*8
			o.target_y = target_space.y*8
		end
		
		if o.target_x == o.x and o.target_y == o.y then
			o.last_player_sighting_space.resolved = true
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
				if space_collider(target_space) == 0 then
					o.target_x = target_space.x*8
					o.target_y = target_space.y*8
					o.prev_move_index = test_index
					break;
				end
			end
		end
	end
end