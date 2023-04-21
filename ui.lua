function draw_ui()
	local x = player.x - 60
	local y = player.y - 60
	local ui_width = 58
	local ui_height = 12
	rectfill(x, y, x+ui_width, y+ui_height, 5)
	rect(x, y, x+ui_width, y+ui_height, 7)
	
	print("🅾️items", x+4, y+4, 7)
	
	if inventory_index <= #inventory_items then
		print("❎", x+38, y+4, 7)
		spr(inventory_items[inventory_index], x+46, y+2)
	end
end