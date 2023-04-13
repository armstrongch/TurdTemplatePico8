function update_enemy(o)
	local enemy_space = {x = flr(o.target_x/8), y = flr(o.target_y/8) }
	local player_space = {x = flr(player.target_x/8), y = flr(player.target_y/8) }
	o.draw_exclamation = line_of_sight(enemy_space, player_space)
end


function draw_enemy(o)
	spr(o.sprite_index, o.x, o.y)
	if o.draw_exclamation then
		spr(6, o.x + 2, o.y - 2)
	end
end