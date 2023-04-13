selected_conversation = -1
selected_response_index = 1

function show_game_state()
	state = "playgame"
end

function show_conversation(collision_object, obj_convo_index)
	local counter = 0
	for c in all(conversations) do
		if (c.sprite == collision_object) then
			if counter == obj_convo_index then
				state = "dialogue"
				selected_conversation = c
				selected_response_index = 1
				break
			else
				counter += 1
			end
		end
	end
end

conversations = 
{
	{
		text = { "hello, how are you?" },
		responses =
		{
			{ "i am good.", "show_convo", 2 },
			{ "i am not so good.", "show_convo", 1 },
		},
		sprite = 3,
	},
	{
		text = { "sorry to hear that,", "i hope you feel better soon" },
		responses = { 
			{ "thanks", "end_conversation" }
		},
		sprite = 3,
	},
	{
		text = { "have a great day." },
		responses = {
			{ "thanks", "end_conversation" }
		},
		sprite = 3,
	},
	{
		text = { "go through the door?" },
		responses = {
			{ "yes", "go_through_door" },
			{ "no", "end_conversation" }
		},
		sprite = 4,
	},
}

function update_dialogue()
	if btnp(2) then 
		selected_response_index -= 1
		if selected_response_index < 1 then
			selected_response_index = #selected_conversation.responses
		end
	elseif btnp(3) then
		selected_response_index += 1
		if selected_response_index > #selected_conversation.responses then
			selected_response_index = 1
		end
	end
	
	if btnp(5) then
		local action = selected_conversation.responses[selected_response_index][2]
		if action == "end_conversation" then
			show_game_state()
		elseif action == "show_convo" then
			show_conversation(selected_conversation.sprite, selected_conversation.responses[selected_response_index][3])
		elseif action == "go_through_door" then
			move_one_space_in_dir(player, player.prev_move_dir)
			move_one_space_in_dir(player, player.prev_move_dir)
			show_game_state()
		end
	end
end

function draw_dialogue()
	camera(0,0)
	rectfill(0,0,127,127,0)
	y_pos = 8
	
	spr(selected_conversation.sprite, 4, y_pos)
	
	for m in all(selected_conversation.text) do
		print(m, 16, y_pos, 7)
		y_pos += 16
	end
	
	for m in all(selected_conversation.responses) do
		print(m[1], 16, y_pos, 7)
		y_pos += 16
	end
	print("❎", 4, (#selected_conversation.text + selected_response_index)*16 - 8, 7)
end