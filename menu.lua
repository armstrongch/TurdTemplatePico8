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
		
		if selected_menu_item_index == 3 then
			init_game()
			state = "playgame"
		end
		
		if selected_menu_item_index == 4 then
			state = "howtoplay"
		end
		
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
	local credits = {
		"design by", "person and person", "",
		"code by", "person", "",
		"music by", "person", "",
		"special thanks", "person, person, person", "person, person"
	}
	local y_pos = 8
	for m in all(credits) do
		print(m, 16, y_pos, 7)
		y_pos += 8
	end
	y_pos += 8
	print("❎", 4, y_pos, 7)
	print("back", 16, y_pos, 7)
end

function update_howtoplay()

	if btnp(5) then state = "menu" end
	
	if btnp(1) then
		instruction_page += 1
		if instruction_page > instruction_page_count then instruction_page = 1 end
	end
	if btnp(0) then
		instruction_page -= 1
		if instruction_page < 1 then instruction_page = instruction_page_count end
	end
end

instruction_lines = {
	"here is some tutorial text",
	"",
	"when you write this text",
	"in the menu lua file,",
	"make sure not to exceed",
	"30 characters per line,",
	"or it will run off the",
	"page.",
	"blah blah blah",
	"blah blah blah",
	"blah blah blah",
	"blah blah blah",
	"blah blah blah",
	"lorem ipsum dolor sit amet,",
	"consectetur adipiscing elit,",
	"sed do eiusmod tempor",
	"incididunt ut labore et dolore",
	"magna aliqua. ut enim ad minim",
	"veniam, quis nostrud",
	"exercitation ullamco laboris",
	"nisi ut aliquip ex ea commodo",
	"consequat. duis aute",
	"iruredolor in",
	"reprehenderit in",
	"voluptate velit esse cillum",
	"dolore eu fugiat nulla",
	"pariatur. excepteur sint",
	"occaecat cupidatat non",
	"proident, sunt in culpa qui",
	"officia deserunt mollit anim",
	"id est laborum."
}

instruction_page = 1
instruction_lines_per_page = 10
instruction_page_count = ceil(#instruction_lines / instruction_lines_per_page)

function draw_howtoplay()
	rectfill(0,0,127,127,0)
	
	local y_pos = 8
	page_num_text = "⬅️ page " .. instruction_page .. " of " .. instruction_page_count .. " ➡️"
	print(page_num_text, 4, y_pos, 7)
	y_pos += 16
	
	local instruction_line_start_index = (instruction_page-1)*10 + 1
	
	for m=instruction_line_start_index, min(instruction_line_start_index+instruction_lines_per_page,#instruction_lines) do
		print(instruction_lines[m], 4, y_pos, 7)
		y_pos += 8
	end
	y_pos += 8
	print("❎", 4, y_pos, 7)
	print("back", 16, y_pos, 7)
end



