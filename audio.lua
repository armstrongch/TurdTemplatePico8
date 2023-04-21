sound_on = true
music_on = true

function sound(sound_name)
	if sound_on then
		if sound_name == "walk" then sfx(0)
		elseif sound_name == "alert" then sfx(1) end
	end
end

function toggle_music()
	music_on = not music_on
	local music_string = "music: off"
	if music_on then music_string = "music: on" end
	menuitem(1, music_string, function() toggle_music() return true end)
	menu_items[5] = music_string
end

function toggle_sound()
	sound_on = not sound_on
	local sound_string = "sound: off"
	if sound_on then sound_string = "sound: on" end
	menuitem(2, sound_string, function() toggle_sound() return true end)
	menu_items[6] = sound_string
end

menuitem(1, "music: on", function() toggle_music() return true end)
menuitem(2, "sound: on", function() toggle_sound() return true end)