--cd c:/users/chris/appdata/roaming/pico-8/carts/turd_template
--special characters:
--❎🅾️⬆️⬇️⬅️➡️

function _init()
	state = "menu"
end

function _update()
	if state == "menu" then
		update_menu()
	elseif state == "credits" then
		update_credits()
	elseif state == "howtoplay" then
		update_howtoplay()
	end
end

function _draw()
	if state == "menu" then draw_menu() end
	if state == "credits" then draw_credits() end
	if state == "howtoplay" then draw_howtoplay() end
end