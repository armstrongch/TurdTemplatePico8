--cd c:/users/chris/appdata/roaming/pico-8/carts/turd_template

function _init()
	state = "menu"
end

function _update()
	if state == "menu" then update_menu() end
end

function _draw()
	if state == "menu" then draw_menu() end
end