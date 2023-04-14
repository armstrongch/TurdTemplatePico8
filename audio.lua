sound_on = true
music_on = true

function sound(sound_name)
	if sound_on then
		if sound_name == "walk" then sfx(0)
		elseif sound_name == "alert" then sfx(1) end
	end
end