menu_items = { "game title", "a game by your name", "start game", "how to play", "music: on", "sound: on", "credits" }
selected_menu_item_index = 3

function update_menu()
	
	if btnp(3) then
		selected_menu_item_index += 1
		if selected_menu_item_index > #menu_items then
			selected_menu_item_index = 3
		end
	end
	
	if btnp(2) then
		selected_menu_item_index -= 1
		if selected_menu_item_index < 3 then
			selected_menu_item_index = #menu_items
		end
	end
	
	if btnp(5) then
		
		if selected_menu_item_index == 5 then
			music_on = not music_on
			if music_on then
				menu_items[selected_menu_item_index] = "music: on"
			else
				menu_items[selected_menu_item_index] = "music: off"
			end
		end
		
		if selected_menu_item_index == 6 then
			sound_on = not sound_on
			if sound_on then
				menu_items[selected_menu_item_index] = "sound: on"
			else
				menu_items[selected_menu_item_index] = "sound: off"
			end
		end
		
		if selected_menu_item_index == 7 then
			state = "credits"
		end
	end
	
end

function draw_menu()
	rectfill(0,0,127,127,0)
	y_pos = 8
	for m in all(menu_items) do
		print(m, 16, y_pos, 7)
		y_pos += 16
	end
	print("❎", 4, selected_menu_item_index*16 - 8, 7)
	
end

function update_credits()
	if btnp(5) then state = "menu" end
end

function draw_credits()
	rectfill(0,0,127,127,0)
	credits = {
		"design by", "person and person", "",
		"code by", "person", "",
		"music by", "person", "",
		"special thanks", "person, person, person", "person, person"
	}
	y_pos = 8
	for m in all(credits) do
		print(m, 16, y_pos, 7)
		y_pos += 8
	end
	y_pos += 8
	print("❎", 4, y_pos, 7)
	print("back", 16, y_pos, 7)
end



