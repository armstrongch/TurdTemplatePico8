--if there are no possible moves, or if the start == target, this will return the start space
function closest_empty_adjacent_space(start_space, target_space)
	if spaces_equal(start_space, target_space) then
		return start_space
	else
		local possible_moves = {
			{ x = start_space.x + 1, y = start_space.y },	--right
			{ x = start_space.x, y = start_space.y + 1 },	--down
			{ x = start_space.x - 1, y = start_space.y },	--left
			{ x = start_space.x, y = start_space.y - 1 }	--up
		}
		local best_dist = -1
		local best_space = start_space
		
		for test_space in all(possible_moves) do
			if space_collider(test_space) == 0 then
				local test_dist = distance_between_spaces(target_space, test_space)
				if best_dist == -1 or test_dist < best_dist then
					best_dist = test_dist
					best_space = test_space
				end
			end
		end
		
		return best_space
	end
end

function line_of_sight(space_1, space_2)
	
	if spaces_equal(space_1, space_2) then
		return true
	elseif distance_between_spaces(space_1, space_2) > 8 then
		--enemies offscreen should not have LOS to the player
		return false
	else
		
		local x1 = space_1.x*8 + 4
		local y1 = space_1.y*8 + 4
		local x2 = space_2.x*8 + 4
		local y2 = space_2.y*8 + 4
		
		for x = min(space_1.x, space_2.x), max(space_1.x, space_2.x) do
			for y = min(space_1.y, space_2.y), max(space_1.y, space_2.y) do
				if space_collider({x = x,y = y}) != 0 then
					--add and subtract 1 in either direction to make spaces a little bigger, we want to be more generous to block LOS
					if segment_intersects_space(x1, y1, x2, y2, x*8-1, y*8-1, x*8+9, y*8+9) then
						return false
					end
				end
			end
		end
		
		return true
	end
end

function segment_intersects_space(x1, y1, x2, y2, space_x1, space_y1, space_x2, space_y2)
	if segments_intersect(x1, y1, x2, y2, space_x1, space_y1, space_x2, space_y1) then return true
	elseif segments_intersect(x1, y1, x2, y2, space_x1, space_y2, space_x2, space_y2) then return true
	elseif segments_intersect(x1, y1, x2, y2, space_x1, space_y1, space_x1, space_y2) then return true
	elseif segments_intersect(x1, y1, x2, y2, space_x2, space_y1, space_x2, space_y2) then return true
	else return false end
end

--from https://stackoverflow.com/questions/9043805/test-if-two-lines-intersect-javascript-function
--returns true if segment 1 from (a,b) to (c,d) instersects segment 2 from (p,q) to (r,s)
function segments_intersect(a,b,c,d,p,q,r,s)
	local det = (c - a) * (s - q) - (r - p) * (d - b)
	if det == 0 then
		return false
	else
		local lambda = ((s - q) * (r - a) + (p - r) * (s - b)) / det
		local gamma = ((b - d) * (r - a) + (c - a) * (s - b)) / det
		return (0 < lambda and lambda < 1) and (0 < gamma and gamma < 1)
	end
end

function spaces_equal(space_1, space_2)
	return space_1.x == space_2.x and space_1.y == space_2.y
end

function distance_between_spaces(space_1, space_2)
	return sqrt( (space_1.x-space_2.x)*(space_1.x-space_2.x) + (space_1.y-space_2.y)*(space_1.y-space_2.y) )
end